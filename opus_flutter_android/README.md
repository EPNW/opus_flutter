# opus_flutter_android

The Android implementation of [`opus_flutter`][1].

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

If you wish to use the Android package only, you can add `opus_flutter_android` as a
dependency:

```yaml
...
dependencies:
  ...
  opus_flutter_android: ^2.0.0
  ...
```

## How opus is contained in this package
The instructions from [libopus-Android.mk](https://github.com/EPNW/libopus-Android.mk) where used to set up opus for Android. Then, the `.git` folder of the cloned opus was deleted, so that the opus source files are included in this repo.


[1]: ../opus_flutter