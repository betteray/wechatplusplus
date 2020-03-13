/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.
*/

@interface MMUILongPressImageView : UIView
@end

%hook MMHeadImageView

- (void)updateUsrName:(NSString *)usrName withHeadImgUrl:(NSString *)url {
	%orig;

    NSString *mySelfUserName = [[%c(SettingUtil) performSelector:@selector(getMainSetting)] performSelector:@selector(m_nsUsrName)];
    MMUILongPressImageView *headImageView = MSHookIvar<MMUILongPressImageView *>(self, "_headImageView");
    headImageView.transform = CGAffineTransformMake([usrName isEqualToString:mySelfUserName] ? -1 : 1, 0, 0, 1, 0, 0);
}

%end

