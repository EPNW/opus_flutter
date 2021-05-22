import 'dart:ffi';
import 'dart:io' show Platform;

import 'package:opus_flutter_platform_interface/opus_flutter_platform_interface.dart';

import 'package:opus_flutter_android/opus_flutter_android.dart';

// A workaround for flutter issue 52267
// TODO: revise once the issue got resolved
void _flutterIssue52267Workaround() {
  if (Platform.isAndroid) {
    if (!(OpusFlutterPlatform.instance is OpusFlutterAndroid)) {
      OpusFlutterPlatform.instance = new OpusFlutterAndroid();
    }
  } else if (Platform.isIOS) {}
}

Future<DynamicLibrary> load() {
  _flutterIssue52267Workaround();
  return OpusFlutterPlatform.instance.load();
}
