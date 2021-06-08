import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:opus_flutter_platform_interface/opus_flutter_platform_interface.dart';
import 'package:inject_js/inject_js.dart' as InjectJs;
import 'package:web_ffi/web_ffi.dart';
import 'package:web_ffi/web_ffi_modules.dart';

/// An implementation of [OpusFlutterPlatform] for web.
class OpusFlutterWeb extends OpusFlutterPlatform {
  static void registerWith(Registrar registrar) {
    OpusFlutterPlatform.instance = new OpusFlutterWeb();
  }

  bool _injected = false;
  Module? _module;

  /// Opens the WebAssembly opus library contained in this plugin and
  /// injects the JavaScript glue if necessary.
  ///
  /// Registers the memory of the created [web_ffi DynamicLibrary](https://pub.dev/documentation/web_ffi/latest/web_ffi/DynamicLibrary-class.html)
  /// as [Memory.global] if there is no global memory yet.
  Future<dynamic> load() async {
    if (!_injected) {
      await InjectJs.importLibrary(
          './assets/packages/opus_flutter_web/assets/libopus.js');
      _injected = true;
    }
    if (_module == null) {
      Memory.init();
      ByteData wasmBinary = await rootBundle
          .load('packages/opus_flutter_web/assets/libopus.wasm');
      _module = await EmscriptenModule.compile(
          wasmBinary.buffer
              .asUint8List(wasmBinary.offsetInBytes, wasmBinary.lengthInBytes),
          'libopus');
    }
    return new DynamicLibrary.fromModule(_module!);
  }
}
