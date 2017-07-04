
#import <UIKit/UIKit.h>
#import "AppNavigationDelegate.h"
#import <React/RCTRootView.h>

@interface ReactViewController : UIViewController {
  id<AppNavigationDelegate> navigation;
  NSString* name;
  NSDictionary* params;
  NSString* navigateType;
  RCTBridge* bridge;
}

@property (nonatomic,weak) UIColor* backGroundColor;

- (id)initWithDelegate:(id<AppNavigationDelegate>)delegate bridge:(RCTBridge *)inBridge viewName:(NSString *)inName navigateType:(NSString*)byType viewParams:(NSDictionary *)inParams;

@end

