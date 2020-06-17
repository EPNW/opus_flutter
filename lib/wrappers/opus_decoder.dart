/// Like opus_decoder from [opus_dart](https://pub.dev/packages/opus_dart), but uses the internal libopus on Android and iOS.
library opus_decoder;
export 'package:opus_dart/wrappers/opus_decoder.dart' hide init;

import 'dart:ffi';
import 'package:opus_dart/wrappers/opus_decoder.dart' as opus_decoder show init;
import '../src/loader.dart' as Loader;

/// Initialises the generated code. This must be the first call to this file.
///
/// On Android and iOS the version of libopus build by this plugin is used.
/// When this plugin should be used on any other platform, libopus has
/// to be loaded manually and passed to this method using the [other]
/// parameter. If you don't want to run on Android and iOS, have a look
/// at the [opus_dart](https://pub.dev/packages/opus_dart) package instead.
void init([DynamicLibrary other]) => opus_decoder.init(Loader.loadInternal(other: other));