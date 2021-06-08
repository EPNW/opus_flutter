import 'dart:typed_data';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

Future<void> shareOrDownload(Uint8List data) async {
  String path = (await getTemporaryDirectory()).absolute.path + '/output.wav';
  File file = new File(path);
  await file.writeAsBytes(data);
  try {
    await Share.shareFiles([path]);
  } on UnimplementedError {
    print('It seems that your platform does not implement sharing yet...');
    print('Here is your file: $path');
  }
}
