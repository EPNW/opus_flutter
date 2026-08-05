#!/usr/bin/env bash
#
# Rebuilds ios/opus.xcframework from an official opus release.
#
# The framework it produces carries three architectures:
#
#   ios-arm64                    device
#   ios-arm64_x86_64-simulator   simulator, Apple Silicon and Intel hosts
#
# The arm64 simulator architecture is the reason this script exists. Without it the
# link step on an Apple Silicon Mac fails with "Framework 'opus' not found", because
# no slice matches the arm64-ios-simulator target.
#
# Usage:
#   ./tool/build_opus_xcframework.sh [opus-version]
#
# Requirements: Xcode command line tools, CMake, curl.

set -euo pipefail

OPUS_VER="${1:-1.5.2}"
MIN_IOS="13.0"
BUNDLE_ID="org.opus-codec.org"

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_XCFW="$HERE/../ios/opus.xcframework"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

echo "Building opus ${OPUS_VER} for iOS"

curl -fsSL "https://downloads.xiph.org/releases/opus/opus-${OPUS_VER}.tar.gz" \
  | tar xz -C "$WORK"
SRC="$WORK/opus-${OPUS_VER}"

# The autotools configure script cannot cross-configure for the simulator triple,
# so the CMake build is used for both platforms.
build_static() {
  local name="$1" sysroot="$2" archs="$3"
  cmake -S "$SRC" -B "$WORK/build-$name" -G Xcode \
    -DCMAKE_SYSTEM_NAME=iOS \
    -DCMAKE_OSX_SYSROOT="$sysroot" \
    -DCMAKE_OSX_ARCHITECTURES="$archs" \
    -DCMAKE_OSX_DEPLOYMENT_TARGET="$MIN_IOS" \
    -DBUILD_SHARED_LIBS=OFF \
    -DOPUS_BUILD_PROGRAMS=OFF \
    -DOPUS_BUILD_TESTING=OFF >/dev/null
  cmake --build "$WORK/build-$name" --config Release -- \
    -quiet CODE_SIGNING_ALLOWED=NO >/dev/null
}

# opus builds as a static library. It is relinked as a dynamic library here because
# the framework is consumed as a dynamic framework by the CocoaPods integration.
link_dylib() {
  local name="$1" sdk="$2" triple_suffix="$3" arch="$4"
  xcrun -sdk "$sdk" clang -dynamiclib \
    -target "${arch}-apple-ios${MIN_IOS}${triple_suffix}" \
    -isysroot "$(xcrun --sdk "$sdk" --show-sdk-path)" \
    -install_name "@rpath/opus.framework/opus" \
    -compatibility_version 1.0.0 -current_version 1.0.0 \
    -Wl,-all_load \
    "$WORK/build-$name/Release-${sdk}/libopus.a" \
    -o "$WORK/$name-$arch.dylib"
}

write_plist() {
  local plist="$1" platform="$2"
  cat > "$plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key><string>en</string>
	<key>CFBundleExecutable</key><string>opus</string>
	<key>CFBundleIdentifier</key><string>${BUNDLE_ID}</string>
	<key>CFBundleInfoDictionaryVersion</key><string>6.0</string>
	<key>CFBundleName</key><string>opus</string>
	<key>CFBundlePackageType</key><string>FMWK</string>
	<key>CFBundleShortVersionString</key><string>${OPUS_VER}</string>
	<key>CFBundleVersion</key><string>1</string>
	<key>CFBundleSupportedPlatforms</key><array><string>${platform}</string></array>
	<key>MinimumOSVersion</key><string>${MIN_IOS}</string>
	<key>UIDeviceFamily</key><array><integer>1</integer><integer>2</integer></array>
</dict>
</plist>
PLIST
}

assemble_framework() {
  local dest="$1" binary="$2" platform="$3"
  mkdir -p "$dest/Headers" "$dest/Modules"
  cp "$SRC"/include/opus.h "$SRC"/include/opus_defines.h \
     "$SRC"/include/opus_multistream.h "$SRC"/include/opus_types.h "$dest/Headers/"
  cat > "$dest/Modules/module.modulemap" <<'MODMAP'
framework module opus {
  umbrella header "opus.h"
  export *

  module * { export * }
}
MODMAP
  cp "$binary" "$dest/opus"
  write_plist "$dest/Info.plist" "$platform"
}

build_static device iphoneos "arm64"
build_static sim iphonesimulator "arm64;x86_64"

link_dylib device iphoneos "" arm64
link_dylib sim iphonesimulator "-simulator" arm64
link_dylib sim iphonesimulator "-simulator" x86_64
lipo -create "$WORK/sim-arm64.dylib" "$WORK/sim-x86_64.dylib" -output "$WORK/sim.dylib"

assemble_framework "$WORK/fw-device/opus.framework" "$WORK/device-arm64.dylib" iPhoneOS
assemble_framework "$WORK/fw-sim/opus.framework"    "$WORK/sim.dylib"          iPhoneSimulator

rm -rf "$OUT_XCFW"
xcodebuild -create-xcframework \
  -framework "$WORK/fw-device/opus.framework" \
  -framework "$WORK/fw-sim/opus.framework" \
  -output "$OUT_XCFW" >/dev/null

echo "Wrote $OUT_XCFW"
plutil -p "$OUT_XCFW/Info.plist" | grep LibraryIdentifier
