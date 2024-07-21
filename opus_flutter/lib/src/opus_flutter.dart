import 'dart:ffi';
import 'package:opus_flutter_platform_interface/opus_flutter_platform_interface.dart';

/// On supported platforms a `DynamicLibrary` of the [opus audio codec](https://opus-codec.org/) is returned,
/// whereas on not supported platforms an [UnsupportedError] is thrown.
Future<DynamicLibrary> load() {
  return OpusFlutterPlatform.instance.load();
}
