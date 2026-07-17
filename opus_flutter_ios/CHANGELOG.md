## 3.0.2

* Added an `arm64-simulator` slice to `opus.xcframework` (merged into the
  existing simulator slice as a fat `ios-arm64_x86_64-simulator` binary), so
  apps now build and run natively on the iOS Simulator on Apple Silicon Macs
  without falling back to Rosetta / excluding `arm64` for the simulator SDK.


## 3.0.1

* Using new opus.xcframework


## 3.0.0

* Adopt `opus_flutter_platform_interface 3.0.0`


## 2.0.0

* Initial release in federal plugin structure