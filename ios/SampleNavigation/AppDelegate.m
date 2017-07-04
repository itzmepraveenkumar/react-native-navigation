/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import "ReactViewController.h"
#import "HybridNavigationManager.h"
#import "NetworkStatusManager.h"

#define INITIALSCREEN @"Home"


@interface AppDelegate () {
  HybridNavigationManager *manager;
}

@property (strong, nonatomic) UINavigationController *curNavigation;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions: launchOptions];
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.curNavigation = [[UINavigationController alloc] initWithRootViewController:[self getReactCtl:INITIALSCREEN withType:@"push" andParameters:@{}]];
  [self.curNavigation setNavigationBarHidden:YES];
  self.window.rootViewController = self.curNavigation;
  [self.window makeKeyAndVisible];
  return YES;
}

- (ReactViewController*) getReactCtl:(NSString*)screenName withType:(NSString*)type andParameters:(NSDictionary*)params {
  ReactViewController *ctlReact = [[ReactViewController alloc] initWithDelegate:self bridge:self.bridge viewName:screenName navigateType:type viewParams:params];
  ctlReact.backGroundColor = ([type isEqualToString:@"modal"])? [UIColor clearColor] : [UIColor whiteColor];
  return ctlReact;
}

#pragma mark - AppNavigationDelegate
- (void) pushToRootViewController:(NSDictionary *)params {
  [self.curNavigation popToRootViewControllerAnimated:true];
}

- (void) popViewController {
  [self.curNavigation popViewControllerAnimated:YES];
}

- (void) dismissViewController {
  UIViewController *ctlDismiss = [self getPresentedViewController];
  [ctlDismiss dismissViewControllerAnimated:YES completion:nil];
}

- (UIViewController*) getPresentedViewController {
  BOOL isPresentedCtlNotFound = YES;
  UIViewController *ctlDismiss = self.curNavigation;
  while (isPresentedCtlNotFound) {
    if (ctlDismiss.presentedViewController) {
      ctlDismiss = ctlDismiss.presentedViewController;
    }
    else {
      isPresentedCtlNotFound = NO;
    }
  }
  return ctlDismiss;
}

- (void) loadView:(NSString*)screenName withNavigationType:(NSString*)type andData:(NSDictionary*)data {
  ReactViewController *ctlReact = [self getReactCtl:screenName withType:type andParameters:data];
  if ([type isEqualToString:@"modal"]) {
    ctlReact.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    ctlReact.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    UIViewController *ctlPresented = [self getPresentedViewController];
    [ctlPresented presentViewController:ctlReact animated:YES completion:nil];
  }
  else {
    [self.curNavigation pushViewController:ctlReact animated:YES];
  }
}

- (void) enableBack:(BOOL)flag {
  self.curNavigation.interactivePopGestureRecognizer.enabled = flag;
}

- (void) viewDidAppear:(NSString*)screenName {
  [manager sendEventWithName:@"VIEWAPPEARED" body:@{@"screenName":screenName}];
}

#pragma mark RCTBridgeDelegate

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#ifdef DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
#endif
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
}

- (NSArray<id<RCTBridgeModule>> *)extraModulesForBridge:(RCTBridge *)bridge;
{
  manager = [[HybridNavigationManager alloc] initWithBridge:_bridge navigationDelegate:self];
  return @[
           manager,
           [[NetworkStatusManager alloc] initWithBridge:_bridge]
           ];
}

@end
