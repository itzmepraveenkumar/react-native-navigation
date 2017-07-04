//
//  NetworkStatusManager.h
//  MLMobile
//
//  Created by Dojo on 10/3/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <Foundation/Foundation.h>

@interface NetworkStatusManager : RCTEventEmitter <RCTBridgeModule>

- (id)initWithBridge:(RCTBridge *)bridge;

@end
