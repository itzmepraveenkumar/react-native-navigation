#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import "AppNavigationDelegate.h"


@interface HybridNavigationManager : RCTEventEmitter <RCTBridgeModule>

 - (id)initWithBridge:(RCTBridge *)bridge navigationDelegate:(id<AppNavigationDelegate>)delegate;

@end
