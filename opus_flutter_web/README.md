# opus_flutter_web

The web implementation of [`opus_flutter`][1].

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

If you wish to use the web package only, you can add `opus_flutter_web` as a
dependency:

```yaml
...
dependencies:
  ...
  opus_flutter_web: ^3.0.0
  ...
```

## How opus is contained in this package
[Emscripten](https://emscripten.org) was used to build WebAssembly and the JavaScript glue. The build commands can be found in the [Dockerfile](./Dockerfile). Then, both, the WebAssembly and JavaScript file are added as Flutter assets and used from there. See [web_ffi's example](https://github.com/EPNW/web_ffi/blob/master/example/README.md) for more information on how WebAssembly can be loaded.


[1]: ../opus_flutter