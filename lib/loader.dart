/// Utils to load libopus as [DynamicLibrary].
///
/// You only need this if you need a reference to the the [DynamicLibrary] outside of this plugin.
library loader;
export 'src/loader.dart' show load;