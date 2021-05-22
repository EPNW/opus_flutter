# opus_flutter_windows

The Windows implementation of [`opus_flutter`][1].

## Usage

### Import the package

This package has been endorsed, meaning that you only need to add `opus_flutter`
as a dependency in your `pubspec.yaml`. It will be automatically included in your app
when you depend on `package:opus_flutter`.

This is what the above means to your `pubspec.yaml`:

```yaml
...
dependencies:
  ...
  opus_flutter: ^2.0.0
  ...
```

If you wish to use the Windows package only, you can add `opus_flutter_windows` as a
dependency:

```yaml
...
dependencies:
  ...
  opus_flutter_windows: ^2.0.0
  ...
```

## How opus is contained in this package
Until Flutters Windows build system is more mature, we are follwing the recommendation from [Define distribution system for native libraries in Pub and/or Flutter](https://github.com/dart-lang/sdk/issues/36712).
This means, that prebuild opus libraries are contained in this package for x86 and x86_64 architectures. They are on runtime copied to a temporary directory using [path_provider](https://pub.dev/packages/path_provider) and then loaded from there.


[1]: ../opus_flutter