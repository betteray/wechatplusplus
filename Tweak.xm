/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.
*/

static UIViewController * viewControllerForView(UIView *view) {
  for (UIView* next = [view superview]; next; next = next.superview) {
    UIResponder* nextResponder = [next nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
      return (UIViewController*)nextResponder;
    }
  }
  return nil;
}

@interface MMUILongPressImageView : UIView
@end

%hook MMHeadImageView

- (id)initWithUsrName:(NSString *)usrName headImgUrl:(NSString *)url bAutoUpdate:(BOOL)autoUpdate bRoundCorner:(BOOL)roundCorner {
    %log; // Write a message about this call, including its class, name and arguments, to the system log.
	return %orig; // Call through to the original function with its original arguments.
}

- (void)updateUsrName:(NSString *)usrName withHeadImgUrl:(NSString *)url {
    %log;
	%orig;

    // UIView *view = (UIView *)self;
    // UIViewController *vc = viewControllerForView(view);
    // if ([vc isKindOfClass:NSClassFromString(@"BaseMsgContentViewController")]) {
        
    // }

    %log;

    NSString *mySelfUserName = [[%c(SettingUtil) performSelector:@selector(getMainSetting)] performSelector:@selector(m_nsUsrName)];
    // NSString *userName = [view valueForKey:@"nsUsrName"];
    if ([usrName isEqualToString:mySelfUserName]) {
        %log;
        MMUILongPressImageView *headImageView = MSHookIvar<MMUILongPressImageView *>(self, "_headImageView");
        headImageView.transform = CGAffineTransformMake(-1, 0, 0, 1, 0, 0);
    } else {
        %log;
        MMUILongPressImageView *headImageView = MSHookIvar<MMUILongPressImageView *>(self, "_headImageView");
        headImageView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    }
}

- (void)ImageDidLoad:(id)image Url:(id)url {
    %log; // Write a message about this call, including its class, name and arguments, to the system log.
	%orig; // Call through to the original function with its original arguments.

    UIView *view = (UIView *)self;
    UIViewController *vc = viewControllerForView(view);
    if ([vc isKindOfClass:NSClassFromString(@"BaseMsgContentViewController")]) {
        NSString *userName = [view valueForKey:@"nsUsrName"];
        if ([userName isEqualToString:@"rowhongwei"]) {
            MMUILongPressImageView *headImageView = MSHookIvar<MMUILongPressImageView *>(self, "_headImageView");
            headImageView.transform = CGAffineTransformMake(-1, 0, 0, 1, 0, 0);
        }
    }
}

%end

