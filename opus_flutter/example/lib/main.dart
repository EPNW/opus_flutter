import 'dart:convert';
import 'dart:math' show min;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:opus_flutter/opus_flutter.dart' as opus_flutter;
import 'package:opus_dart/opus_dart.dart';
import 'package:share_plus/share_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initOpus(await opus_flutter.load());
  runApp(const OpusFlutter());
}

/// Even if we could load the file as whole, we create a stream out of it
/// to simulate streaming behaviour (e.g. if the stream comes over the network).
Stream<List<int>> exampleRawStream(BuildContext context) async* {
  const int portionSize =
      65535; //equals the usual size you get per list in a network stream
  ByteData data = await DefaultAssetBundle.of(context)
      .load('assets/s16le_16000hz_mono.raw');
  int i = 0;
  while (i != data.lengthInBytes) {
    int r = min(portionSize, data.lengthInBytes - i);
    yield data.buffer.asUint8List(data.offsetInBytes + i, r);
    i += r;
    await Future.delayed(
        const Duration(milliseconds: 10)); //Simulate network latency
  }
}

class OpusFlutter extends StatelessWidget {
  const OpusFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('opus_flutter'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Text('Version: ${getOpusVersion()}\n'),
              const OpusExample()
            ])),
      ),
    );
  }
}

class OpusExample extends StatefulWidget {
  const OpusExample({super.key});

  @override
  State<OpusExample> createState() => _OpusExampleState();
}

class _OpusExampleState extends State<OpusExample> {
  bool _processing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_processing) {
      return const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[CircularProgressIndicator(), Text('Processing...')],
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          setState(() {
            _processing = true;
          });
          example(exampleRawStream(context)).then((Uint8List data) {
            setState(() {
              _processing = false;
            });
            _share(data);
          });
        },
        child: const Text('Start'),
      );
    }
  }
}

/// This is mostly the same example as from the opus_dart package:
/// Get a stream, encode it and decode it, then share it.
/// Add a wav header, so it can be played by any sound app.
Future<Uint8List> example(Stream<List<int>> input) async {
  const int sampleRate = 16000;
  const int channels = 1;
  List<Uint8List> output = [];
  output.add(Uint8List(wavHeaderSize)); //Reserve space for the header
  //Encode and decode using opus
  await input
      .transform(StreamOpusEncoder.bytes(
          floatInput: false,
          frameTime: FrameTime.ms20,
          sampleRate: sampleRate,
          channels: channels,
          application: Application.audio,
          copyOutput: true,
          fillUpLastFrame: true))
      .cast<Uint8List?>()
      .transform(StreamOpusDecoder.bytes(
          floatOutput: false,
          sampleRate: sampleRate,
          channels: channels,
          copyOutput: true,
          forwardErrorCorrection: false))
      .cast<Uint8List>()
      .forEach(output.add);
  int length = output.fold(0, (int l, Uint8List element) => l + element.length);
  //Write the wav header
  Uint8List header =
      wavHeader(channels: channels, sampleRate: sampleRate, fileSize: length);
  output[0] = header;
  // Merge into a single Uint8List
  Uint8List flat = Uint8List(length);
  int index = 0;
  for (Uint8List element in output) {
    flat.setAll(index, element);
    index += element.length;
  }
  return flat;
}

const int wavHeaderSize = 44;

Uint8List wavHeader(
    {required int sampleRate, required int channels, required int fileSize}) {
  const int sampleBits = 16; //We know this since we used opus
  const Endian endian = Endian.little;
  final int frameSize = ((sampleBits + 7) ~/ 8) * channels;
  ByteData data = ByteData(wavHeaderSize);
  data.setUint32(4, fileSize - 4, endian);
  data.setUint32(16, 16, endian);
  data.setUint16(20, 1, endian);
  data.setUint16(22, channels, endian);
  data.setUint32(24, sampleRate, endian);
  data.setUint32(28, sampleRate * frameSize, endian);
  data.setUint16(30, frameSize, endian);
  data.setUint16(34, sampleBits, endian);
  data.setUint32(40, fileSize - 44, endian);
  Uint8List bytes = data.buffer.asUint8List();
  bytes.setAll(0, ascii.encode('RIFF'));
  bytes.setAll(8, ascii.encode('WAVE'));
  bytes.setAll(12, ascii.encode('fmt '));
  bytes.setAll(36, ascii.encode('data'));
  return bytes;
}

void _share(Uint8List data) async {
  XFile file = XFile.fromData(
    data,
    mimeType: 'audio/wav',
    name: 'output.wav',
    length: data.length,
  );
  await Share.shareXFiles([file]);
}
