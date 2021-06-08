import 'package:opus_flutter_platform_interface/opus_flutter_platform_interface.dart';

/// On supported platforms a `DynamicLibrary` of the [opus audio codec](https://opus-codec.org/) is returned,
/// whereas on not supported platforms an [UnsupportedError] is thrown.
///
/// On platforms where there is [dart:ffi], the returned object is a
/// [dart:ffi DynamicLibrary](https://api.dart.dev/stable/dart-ffi/DynamicLibrary-class.html),
/// so it is safe to cast it.
///
/// On the web, where there is no [dart:ffi], the returned object is a
/// [web_ffi DynamicLibrary](https://pub.dev/documentation/web_ffi/latest/web_ffi/DynamicLibrary-class.html),
/// so it is safe to cast it.
Future<dynamic> load() {
  return OpusFlutterPlatform.instance.load();
}
