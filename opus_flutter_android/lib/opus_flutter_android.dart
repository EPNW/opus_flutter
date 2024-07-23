import 'dart:async';
import 'dart:ffi';

import 'package:opus_flutter_platform_interface/opus_flutter_platform_interface.dart';

/// An implementation of [OpusFlutterPlatform] for Android.
class OpusFlutterAndroid extends OpusFlutterPlatform {
  /// Registers this class as the default instance of [OpusFlutterPlatform].
  static void registerWith() {
    OpusFlutterPlatform.instance = OpusFlutterAndroid();
  }

  /// Opens the shared opus library build by this plugin.
  @override
  Future<DynamicLibrary> load() async {
    return DynamicLibrary.open('libopus.so');
  }
}
