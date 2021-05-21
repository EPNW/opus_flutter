import 'dart:ffi';

import 'package:opus_flutter_platform_interface/opus_flutter_platform_interface.dart';

Future<DynamicLibrary> load() => OpusFlutterPlatform.instance.load();
