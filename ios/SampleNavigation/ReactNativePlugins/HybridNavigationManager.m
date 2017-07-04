#import "AppNavigationDelegate.h"
#import "HybridNavigationManager.h"
#import <React/RCTRootView.h>
#import <React/RCTUIManager.h>

@implementation HybridNavigationManager {
  __weak id<AppNavigationDelegate> _delegate;
}

@synthesize bridge = _bridge;

- (id)initWithBridge:(RCTBridge *)bridge navigationDelegate:(id<AppNavigationDelegate>)delegate
{
  if (self = [super init]) {
    _bridge = bridge;
    _delegate = delegate;
  }
  return self;
}

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(navigate:(NSString *)name withNavigationType:(NSString*)type andData:(NSDictionary*)data)
{
  [_delegate loadView:name withNavigationType:type andData:data];
}

RCT_EXPORT_METHOD(goBack:(NSString*)name withNavigationType:(NSString*)type andData:(NSDictionary*)data)
{
  if ([type isEqualToString:@"modal"]) {
    [_delegate dismissViewController];
  }
  else {
    [_delegate popViewController];
  }
  if (data) {
    [self sendEvents:@"EVENTBACK" and:data];
  }
}

RCT_EXPORT_METHOD(enableBack:(NSString*)flag)
{
  if ([@"1" isEqualToString:flag]) {
    [_delegate enableBack:YES];
  }
  else {
    [_delegate enableBack:NO];
  }
}

RCT_EXPORT_METHOD(saveEventInAnalytics:(NSString*)eventName and:(NSDictionary*)properties)
{
  if (eventName) {
    if (properties) {
      //[[Mixpanel sharedInstance] track:eventName properties:properties];
    }
    //[[Mixpanel sharedInstance] track:eventName];
  }
}

RCT_EXPORT_METHOD(sendJSEvent:(NSString*)eventName and:(NSDictionary*)params)
{
  [self sendEvents:eventName and:params];
}

RCT_EXPORT_METHOD(titleValue:(nonnull NSNumber *)rootTag title:(nonnull NSString *)title)
{
  RCTRootView *rootView = (RCTRootView *)[_bridge.uiManager viewForReactTag: rootTag];
  rootView.reactViewController.navigationItem.title = title;
}

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"EVENTBACK",@"VIEWAPPEARED"];
}

- (void)sendEvents:(NSString*)name and:(NSDictionary*)data
{
  [self sendEventWithName:name body:data];
}

@end

