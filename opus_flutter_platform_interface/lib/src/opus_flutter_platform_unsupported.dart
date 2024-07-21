import 'dart:async';
import 'dart:ffi';

import 'opus_flutter_platform_interface.dart';

/// An implementation of [OpusFlutterPlatform] that throws an [UnsupportedError] when attempting to call [load()].
class OpusFlutterPlatformUnsupported extends OpusFlutterPlatform {

  /// Always throws an [UnsupportedError].
  Future<DynamicLibrary> load() {
    throw new UnsupportedError('Automatic loading is not supported on this platform!');
  }
}