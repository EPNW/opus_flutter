import 'dart:async';
import 'dart:ffi';

import 'package:opus_flutter_platform_interface/opus_flutter_platform_interface.dart';

/// An implementation of [OpusFlutterPlatform] for Android.
class OpusFlutterAndroid extends OpusFlutterPlatform {

  static void registerWith(Registrar registrar) {
    OpusFlutterPlatform.instance = new OpusFlutterAndroid();
  }

  /// Opens the shared opus library build by this plugin.
  Future<DynamicLibrary> load() async{
    return DynamicLibrary.open('libopus.so');
  }
}