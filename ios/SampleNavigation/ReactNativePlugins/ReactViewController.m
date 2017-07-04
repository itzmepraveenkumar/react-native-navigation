
#import "ReactViewController.h"
#import <React/RCTRootView.h>
#import "AppDelegate.h"

@interface ReactViewController () <UIGestureRecognizerDelegate>
@end
@implementation ReactViewController

- (id)initWithDelegate:(id<AppNavigationDelegate>)delegate bridge:(RCTBridge *)inBridge viewName:(NSString *)inName navigateType:(NSString*)type viewParams:(NSDictionary *)inParams
{
  self = [super init];
  if (self) {
    navigation = delegate;
    name = inName;
    navigateType = type;
    params = inParams;
    bridge = inBridge;
  }
  return self;
}

- (void)loadView {
  self.navigationItem.title = @"";
  NSLog(@"%@",params);
  NSLog(@"%@",navigateType);
  self.view = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"SampleNavigation" initialProperties:@{@"name":name,@"data":params,@"type":navigateType}];
  self.view.backgroundColor = self.backGroundColor;
}

- (void) viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
  [appDelegate viewDidAppear:name];
  self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)requestClose:(UIButton*)sender
{
  [self dismissViewControllerAnimated:true completion:^{}];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
  return self.navigationController.interactivePopGestureRecognizer.enabled;
}

@end


