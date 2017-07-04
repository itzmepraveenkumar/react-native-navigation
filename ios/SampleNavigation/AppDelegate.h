/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <UIKit/UIKit.h>
#import "AppNavigationDelegate.h"
#import <React/RCTRootView.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, RCTBridgeDelegate, AppNavigationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (strong, nonatomic) RCTBridge *bridge;

- (void) viewDidAppear:(NSString*)screenName;

@end
