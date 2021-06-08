import 'dart:async';
import 'dart:ffi';

import 'package:opus_flutter_platform_interface/opus_flutter_platform_interface.dart';

/// An implementation of [OpusFlutterPlatform] for Android.
class OpusFlutterAndroid extends OpusFlutterPlatform {
  /// Opens the shared opus library build by this plugin.
  Future<dynamic> load() async {
    return DynamicLibrary.open('libopus.so');
  }
}
