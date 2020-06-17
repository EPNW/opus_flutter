import 'dart:io' show Platform;
import 'dart:ffi';


/// Loads libopus. Usefull if you need libopus as [DynamicLibrary] outside of this plugin.
///
/// There is no need to call this method if you only need the libraries provided by this plugin.
///
/// Works only on Android and iOS. On other platforms, a [UnsupportedError] is thrown.
DynamicLibrary load(){
  if(Platform.isAndroid){
    return new DynamicLibrary.open('libopus.so');
  } else if(Platform.isIOS) {
    return new DynamicLibrary.process();
  } else {
    _loadError();
  }
}

DynamicLibrary loadInternal({DynamicLibrary other}){
  if(Platform.isAndroid||Platform.isIOS) {
    return load();
  } else if(other!=null){
    return other;
  } else {
   _loadError();
  }
}

void _loadError(){
  throw new UnsupportedError('''opus_flutter can only automatically load libopus on Android and iOS.
If this library should be used on any additional platform, load libopus manually and
pass it to the "other" argument when calling a init method.

If you do not use this plugin on Android or iOS, but an other flutter platform
(Windows, MAC, ...), you are using the wrong plugin. Use opus_dart instead of
opus_flutter.''');
}