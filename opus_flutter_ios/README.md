# opus_flutter_ios

The iOS implementation of [`opus_flutter`][1].

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
  opus_flutter: ^3.0.0
  ...
```

If you wish to use the iOS package only, you can add `opus_flutter_ios` as a
dependency:

```yaml
...
dependencies:
  ...
  opus_flutter_ios: ^3.0.1
  ...
```

## How opus is contained in this package
An `opus.xcframework` is incorporated into this plugin, in the spirit of
[opus_xcframework](https://github.com/EPNW/opus_xcframework).

It carries three architectures:

| Slice | Used for |
| --- | --- |
| `ios-arm64` | devices |
| `ios-arm64_x86_64-simulator` | simulators, on Apple Silicon and Intel hosts |

To reproduce it from an official opus release, run:

```bash
./tool/build_opus_xcframework.sh
```


[1]: ../opus_flutter
