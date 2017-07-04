#import <UIKit/UIKit.h>

@protocol AppNavigationDelegate <NSObject>

- (void) popViewController;
- (void) dismissViewController;
- (void) enableBack:(BOOL)flag;
- (void) loadView:(NSString*)screenName withNavigationType:(NSString*)type andData:(NSDictionary*)data;

@end
