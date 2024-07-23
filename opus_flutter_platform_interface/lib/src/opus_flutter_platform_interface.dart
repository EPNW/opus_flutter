import 'dart:async';
import 'dart:ffi';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'opus_flutter_platform_unsupported.dart';

/// The interface that implementations of opus_flutter must implement.
///
/// Platform implementations should extend this class rather than implement it as `opus_flutter`
/// does not consider newly added methods to be breaking changes. Extending this class
/// (using `extends`) ensures that the subclass will get the default implementation, while
/// platform implementations that `implements` this interface will be broken by newly added
/// [OpusFlutterPlatform] methods.
abstract class OpusFlutterPlatform extends PlatformInterface {
  /// Constructs a OpusFlutterPlatform.
  OpusFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static OpusFlutterPlatform _instance = OpusFlutterPlatformUnsupported();

  /// The default instance of [OpusFlutterPlatform] to use,
  /// defaults to [OpusFlutterPlatformUnsupported].
  static OpusFlutterPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [OpusFlutterPlatform] when they register themselves.
  static set instance(OpusFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Obtains a [DynamicLibrary] of `libopus` on the current platform.
  Future<DynamicLibrary> load() {
    throw UnimplementedError('load() has not been implemented.');
  }
}
