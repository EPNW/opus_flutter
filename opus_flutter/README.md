# opus_flutter
With the upcoming of the federal plugin system, this package was reorganized.
Instead of providing access to the opus functions, it is now just a loader package to obtain a `DynamicLibrary` for  [opus_dart](https://pub.dev/packages/opus_dart) on flutter-based projects.
The overall scheme is now the following:
TODO insert image

## Versioning
Currently, opus 1.3.1 is loaded.

## Why are opus_dart and opus_flutter still two packages?
The answer on that is simlple: dart is more than just flutter. With this split approach, it is easy to obtain a `DynamicLibrary` on flutter-based projects, but it is still possible to use opus_dart without flutter (e.g. on headless servers where there is no need for flutter). An other adventage for flutter developers with this split is, that they have a convenient way to obtain opus as `DynamicLibrary`, but are not forced to use it with opus_dart.

## How this package was build
To see, how the platform packages are build, checkout their respective pages on pub.