import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:opus_flutter_platform_interface/opus_flutter_platform_interface.dart';
import 'package:path_provider/path_provider.dart';

/// An implementation of [OpusFlutterPlatform] for Windows.
class OpusFlutterWindows extends OpusFlutterPlatform {
  static const String _licenseFile = 'opus_license.txt';

  static Future<String> _copyFiles() async {
    String tmpPath = (await getTemporaryDirectory()).absolute.path;
    Directory dir = Directory('$tmpPath/opus_flutter_windows/opus').absolute;
    await dir.create(recursive: true);

    ByteData data;
    File f = File('${dir.path}/$_licenseFile');
    if (!(await f.exists())) {
      data = await rootBundle
          .load('packages/opus_flutter_windows/assets/$_licenseFile');
      await f.writeAsBytes(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    }

    String src;
    String dst;
    if (Platform.version.contains('x64')) {
      src = 'libopus.x64.dll.blob';
      dst = 'libopus.x64.dll';
    } else {
      src = 'libopus.x86.dll.blob';
      dst = 'libopus.x86.dll';
    }

    f = File('${dir.path}/$dst');
    if (!(await f.exists())) {
      data = await rootBundle.load('packages/opus_flutter_windows/assets/$src');
      await f.writeAsBytes(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    }
    return f.path;
  }

  /// Registers this class as the default instance of [OpusFlutterPlatform].
  static void registerWith() {
    OpusFlutterPlatform.instance = OpusFlutterWindows();
  }

  /// Opens the shared opus library included in this plugin.
  Future<DynamicLibrary> load() async {
    String libPath = await _copyFiles();
    return DynamicLibrary.open(libPath);
  }
}
