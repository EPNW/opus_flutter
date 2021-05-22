import 'dart:ffi';
import 'dart:io' show Platform;

import 'package:opus_flutter_android/opus_flutter_android.dart';
import 'package:opus_flutter_ios/opus_flutter_ios.dart';
import 'package:opus_flutter_windows/opus_flutter_windows.dart';
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

// A workaround for flutter/flutter#81421
// TODO: revise once the issue got resolved
void _flutterIssue81421Workaround() {
  if (Platform.isWindows) {
    if (!(OpusFlutterPlatform.instance is OpusFlutterWindows)) {
      OpusFlutterWindows.registerWith();
    }
  }
}

Future<DynamicLibrary> load() {
  _flutterIssue52267Workaround();
  _flutterIssue81421Workaround();
  return OpusFlutterPlatform.instance.load();
}
