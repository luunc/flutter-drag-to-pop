#import "FlutterDragToPopPlugin.h"
#if __has_include(<flutter_drag_to_pop/flutter_drag_to_pop-Swift.h>)
#import <flutter_drag_to_pop/flutter_drag_to_pop-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_drag_to_pop-Swift.h"
#endif

@implementation FlutterDragToPopPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterDragToPopPlugin registerWithRegistrar:registrar];
}
@end
