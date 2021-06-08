@JS()
library js;

import 'dart:typed_data';
import 'package:js/js.dart';
import 'package:inject_js/inject_js.dart' as InjectJs;

@JS('downloadBlob')
external void _download(Uint8List data, String name, String mime);

const String _binaryMime = 'application/octet-stream';

bool _injected = false;

Future<void> saveOrDownload(Uint8List data) async {
  if (!_injected) {
    await InjectJs.importLibrary('assets/download.js');
    _injected = true;
  }
  _download(data, 'output.wav', _binaryMime);
}
