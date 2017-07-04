//
//  NetworkStatusManager.m
//  MLMobile
//
//  Created by Dojo on 10/3/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "NetworkStatusManager.h"
#import "Reachability.h"

@interface NetworkStatusManager() {
  dispatch_queue_t commonTaskQueue;
}

@property (nonatomic) Reachability *internetReachability;

@end

@implementation NetworkStatusManager
@synthesize bridge = _bridge;

- (id)initWithBridge:(RCTBridge *)bridge 
{
  if (self = [super init]) {
    _bridge = bridge;
  }
  self.internetReachability = [Reachability reachabilityForInternetConnection];
  [self.internetReachability startNotifier];
  return self;
}

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue
{
  if(commonTaskQueue == nil)
    commonTaskQueue = dispatch_queue_create("NetworkChange.queue", DISPATCH_QUEUE_SERIAL);
  return commonTaskQueue;
}

RCT_EXPORT_METHOD(checkNetworkStatus:(RCTResponseSenderBlock)callback)
{
  callback(@[[NSNull null],[self getNetworkStatus:self.internetReachability]]);
}

- (void)sendEvents:(NSString*)name and:(NSDictionary *)params
{
  [self sendEventWithName:name body:params];
}

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"NETWORKCHANGE"];
}

- (void) reachabilityChanged:(NSNotification *)note
{
  [self sendEvents:@"NETWORKCHANGE" and:@{@"status":[self getNetworkStatus:self.internetReachability]}];
}

- (NSString*) getNetworkStatus:(Reachability*)curReachabilty {
  switch (curReachabilty.currentReachabilityStatus) {
    case NotReachable:        {
      return @"none";
      break;
    }
    case ReachableViaWWAN:        {
      return @"wwan";
      break;
    }
    case ReachableViaWiFi:        {
      return @"wifi";
      break;
    }
  }
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}


@end
