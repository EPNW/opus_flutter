# opus_flutter_platform_interface

A common platform interface for the [`opus_flutter`][1] plugin.

This interface allows platform-specific implementations of the `opus_flutter`
plugin, as well as the plugin itself, to ensure they are supporting the
same interface.

# Usage

To implement a new platform-specific implementation of `opus_flutter`, extend
[`OpusFlutterPlatform`][2] with an implementation that performs the
platform-specific behavior, and when you register your plugin, set the default
`OpusFlutterPlatform` by calling
`OpusFlutterPlatform.instance = MyPlatformOpusFlutter()`.

# Note on breaking changes

Strongly prefer non-breaking changes (such as adding a method to the interface)
over breaking changes for this package.

See https://flutter.dev/go/platform-interface-breaking-changes for a discussion
on why a less-clean interface is preferable to a breaking change.

[1]: ../opus_flutter
[2]: lib/src/opus_flutter_platform_interface.dart