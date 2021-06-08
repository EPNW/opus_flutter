/// Utils to load libopus as `DynamicLibrary` for usage in [opus_dart](https://pub.dev/packages/opus_dart).
library opus_flutter;

// Once all workarounds in opus_flutter_ffi.dart are fixed and removed, we should
// be able drop the conditional exports
export 'src/opus_flutter_web.dart'
    if (dart.library.ffi) 'src/opus_flutter_ffi.dart';
