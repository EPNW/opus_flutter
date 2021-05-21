# opus_flutter
libopus wrappers for flutter based on [opus_dart](https://pub.dev/packages/opus_dart).
To understand, how this plugin works, take a look at opus_dart first!

## Versioning
Current libopus version: 1.3.1

The current libopus version is determined by the underlying opus_dart package.
The major and minor version of this plugin will always match the opus_dart package, the patch version may be increased independently on small fixes.
To lock on a specific version of opus, see the Versioning section of [opus_dart](https://pub.dev/packages/opus_dart).

## Usage
All functions and libraries have the same signature as in [opus_dart](https://pub.dev/packages/opus_dart), so you can use them
interchangeably. Just replace `package:opus_dart` with `package:opus_flutter` when importing.

The only difference is, that the `library` parameter of all `init` functions is now optional.
Instead of using the `library` parameter, opus_flutter tries to load the version of libopus build into this plugin.
This will only work on Android and iOS. You still have to call the `init` functions of the wrappers (if you want to use them)
and the `initOpus` function of the `opus_dart` library, you just don't need the parameter on Android and iOS!

If you want to use this plugin on additional flutter platforms, you have to
load an instance of libopus on the platform manually and pass it to the init functions. If you want to use opus
with flutter BUT NOT with Android nor iOS, do not use this plugin, but the original [opus_dart](https://pub.dev/packages/opus_dart) instead.

If you need a reference to the build-in libopus as `DynamicLibrary`, you can use the `loader` library.

## How this package was build
This section describes how libopus was build into this plugin.
Most users don't need to care about this section, it serves merely documentational purpose.

### Android
The instructions from [libopus-Android.mk](https://github.com/EPNW/libopus-Android.mk) where used to set up opus for Android. Then, the .git folder of opus was deleted, so that the opus source files are included in this repo.

### iOS [WIP]
With version 1.1.0 of this plugin, we included the xcframework from [here](https://github.com/EPNW/opus_xcframework).