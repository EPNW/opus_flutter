## 3.0.2

* Rebuild `opus.xcframework` with an arm64 simulator slice, fixing
  `Framework 'opus' not found` when building for the iOS simulator on Apple Silicon
* Build every slice from opus 1.5.2, so device and simulator run the same codec version
* Add `tool/build_opus_xcframework.sh`, which reproduces the framework from source


## 3.0.1

* Using new opus.xcframework


## 3.0.0

* Adopt `opus_flutter_platform_interface 3.0.0`


## 2.0.0

* Initial release in federal plugin structure