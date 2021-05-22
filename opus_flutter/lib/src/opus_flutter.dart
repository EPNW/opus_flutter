import 'dart:ffi';
import 'dart:io' show Platform;

import 'package:opus_flutter_android/opus_flutter_android.dart';
import 'package:opus_flutter_ios/opus_flutter_ios.dart';
import 'package:opus_flutter_platform_interface/opus_flutter_platform_interface.dart';

// A workaround for flutter/flutter#52267
// TODO: revise once the issue got resolved
void _flutterIssue52267Workaround() {
  if (Platform.isAndroid) {
    if (!(OpusFlutterPlatform.instance is OpusFlutterAndroid)) {
      OpusFlutterPlatform.instance = new OpusFlutterAndroid();
    }
  } else if (Platform.isIOS) {
    if (!(OpusFlutterPlatform.instance is OpusFlutterIOS)) {
      OpusFlutterPlatform.instance = new OpusFlutterIOS();
    }
  }
}

Future<DynamicLibrary> load() {
  _flutterIssue52267Workaround();
  return OpusFlutterPlatform.instance.load();
}
