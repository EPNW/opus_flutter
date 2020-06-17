import 'dart:io';

const List<String> gen = <String>[
  'opus_custom',
  'opus_decoder',
  'opus_encoder',
  'opus_libinfo',
  'opus_multistream',
  'opus_projection',
  'opus_repacketizer'
];

/// Needs to be run from root folder
Future<void> main() async {
  for (String name in gen) {
    await new File('./lib/wrappers/$name.dart').writeAsString(text(name));
  }
}

String text(String name) => '''/// Like $name from [opus_dart](https://pub.dev/packages/opus_dart), but uses the internal libopus on Android and iOS.
library $name;
export 'package:opus_dart/wrappers/$name.dart' hide init;

import 'dart:ffi';
import 'package:opus_dart/wrappers/$name.dart' as $name show init;
import '../src/loader.dart' as Loader;

/// Initialises the generated code. This must be the first call to this file.
///
/// On Android and iOS the version of libopus build by this plugin is used.
/// When this plugin should be used on any other platform, libopus has
/// to be loaded manually and passed to this method using the [other]
/// parameter. If you don't want to run on Android and iOS, have a look
/// at the [opus_dart](https://pub.dev/packages/opus_dart) package instead.
void init([DynamicLibrary other]) => $name.init(Loader.loadInternal(other: other));''';
