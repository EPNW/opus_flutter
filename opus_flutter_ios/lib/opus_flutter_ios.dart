import 'dart:async';
import 'dart:ffi';

import 'package:opus_flutter_platform_interface/opus_flutter_platform_interface.dart';

/// An implementation of [OpusFlutterPlatform] for iOS.
class OpusFlutterIOS extends OpusFlutterPlatform {
  /// Registers this class as the default instance of [OpusFlutterPlatform].
  static void registerWith() {
    OpusFlutterPlatform.instance = OpusFlutterIOS();
  }

  /// Opens the static opus library build into this plugin.
  @override
  Future<DynamicLibrary> load() async {
    return DynamicLibrary.process();
  }
}
