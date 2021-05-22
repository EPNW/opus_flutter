#import "OpusFlutterIosPlugin.h"
#if __has_include(<opus_flutter_ios/opus_flutter_ios-Swift.h>)
#import <opus_flutter_ios/opus_flutter_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "opus_flutter_ios-Swift.h"
#endif

@implementation OpusFlutterIosPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOpusFlutterIosPlugin registerWithRegistrar:registrar];
}
@end
