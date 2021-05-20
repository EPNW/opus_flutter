/// A dart friendly api for encoding and decoding opus packets.
/// Must be initalized using the [initOpus] function.
library opus_dart;

import 'dart:ffi';

import 'package:opus_dart/opus_dart.dart' as Opus show initOpus;

import 'src/loader.dart' as Loader;

export 'package:opus_dart/opus_dart.dart' hide initOpus;

/// Initalizes libopus.
///
/// On Android and iOS the version of libopus build by this plugin is used.
/// When this plugin should be used on any other platform, libopus has
/// to be loaded manually and passed to this method using the [other]
/// parameter. If you don't want to run on Android and iOS, have a look
/// at the [opus_dart](https://pub.dev/packages/opus_dart) package instead.
void initOpus([DynamicLibrary? other]) =>
    Opus.initOpus(Loader.loadInternal(other: other));