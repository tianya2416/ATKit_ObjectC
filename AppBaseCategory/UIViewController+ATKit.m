//
//  UIViewController+ATKit.m
//  Postre
//
//  Created by wangws1990 on 2019/4/16.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import "UIViewController+ATKit.h"


@implementation UIViewController (ATKit)

- (void)setKeyBoardDismiss
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
- (void)setLargeTitleDisplayModeNever
{
    if (@available(iOS 11.0, *)) {
         self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    }
}
- (void)showNavTitle:(NSString *)title {
    [self showNavTitle:title backItem:YES];
}
- (void)showNavTitle:(NSString *)title backItem:(BOOL)show{
    self.navigationItem.title = title;
    if (show) {
        [self setBackItem:[UIImage imageNamed:@"icon_nav_back"] closeItem:[UIImage imageNamed:@"icon_nav_close"]];
    }
    else {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }
}
- (void)setBackItem:(UIImage *)image {
    [self setBackItem:image closeItem:image];
}
- (void)setBackItem:(UIImage *)image closeItem:(UIImage *)closeImage {
    if (self.navigationController.viewControllers.count == 1 && self.presentingViewController) {
        self.navigationItem.leftBarButtonItem = [self navItemWithImage:closeImage
                                                                 title:(closeImage ? nil : @"ㄨ")
                                                                action:@selector(goBack)];
    }
    else if ((self.navigationController.viewControllers.count > 1 || (!self.navigationController && !self.parentViewController))) {
        self.navigationItem.leftBarButtonItem =  [self navItemWithImage:image
                                                                  title:(image ? nil : @"ㄑ")
                                                                 action:@selector(goBack)];
    }
    else {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }
    ((UIButton *)self.navigationItem.leftBarButtonItem.customView).contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}
- (UIBarButtonItem *)navItemWithImage:(UIImage *)image action:(SEL)action {
    return [self navItemWithImage:image title:nil color:nil action:action];
}
- (UIBarButtonItem *)navItemWithTitle:(NSString *)title action:(SEL)action {
    return [self navItemWithImage:nil title:title color:nil action:action];
}
- (UIBarButtonItem *)navItemWithTitle:(NSString *)title color:(UIColor *)color action:(SEL)action {
    return [self navItemWithImage:nil title:title color:color action:action];
}
- (UIBarButtonItem *)navItemWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action {
    return [self navItemWithImage:image title:title color:nil action:action];
}
- (UIBarButtonItem *)navItemWithImage:(UIImage *)image title:(NSString *)title color:(UIColor *)color action:(SEL)action {
    return [self navItemWithImage:image title:title color:color target:self action:action];
}
- (UIBarButtonItem *)navItemWithImage:(UIImage *)image title:(NSString *)title color:(UIColor *)color target:(id)target action:(SEL)action {
    return [self navItem:NO image:image title:title color:color target:target action:action];
}
- (UIBarButtonItem *)navItem:(BOOL)rightItem image:(UIImage *)image title:(NSString *)title color:(UIColor *)color target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:color ?: [UIColor grayColor] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setContentHorizontalAlignment:rightItem ? UIControlContentHorizontalAlignmentRight : UIControlContentHorizontalAlignmentLeft];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)setNavRightItemWithImage:(UIImage *)image action:(SEL)action {
    [self setNavRightItemWithImage:image title:nil color:nil action:action];
}
- (void)setNavRightItemWithTitle:(NSString *)title action:(SEL)action {
    [self setNavRightItemWithImage:nil title:title color:nil action:action];
}
- (void)setNavRightItemWithTitle:(NSString *)title color:(UIColor *)color action:(SEL)action {
    [self setNavRightItemWithImage:nil title:title color:color action:action];
}
- (void)setNavRightItemWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action {
    [self setNavRightItemWithImage:image title:title color:nil action:action];
}
- (void)setNavRightItemWithImage:(UIImage *)image title:(NSString *)title color:(UIColor *)color action:(SEL)action {
    self.navigationItem.rightBarButtonItem = [self navItem:YES image:image title:title color:[UIColor grayColor] target:self action:action];
}

- (void)goBack {
    [self goBack:YES];
}
- (void)goBack:(BOOL)animated {
    @try {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:animated];
        }
        else if (self.presentingViewController) {
            [self dismissViewControllerAnimated:animated completion:nil];
            [self.view endEditing:YES];
        }
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}
- (void)dismissOrPopToRootControlelr {
    [self dismissOrPopToRootController:YES];
}
- (void)dismissOrPopToRootController:(BOOL)animated {
    @try {
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:animated completion:nil];
            [self.view endEditing:YES];
        }
        else if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popToRootViewControllerAnimated:animated];
        }
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}


+ (UIViewController *)rootTopPresentedController {
    return [self rootTopPresentedControllerWihtKeys:nil];
}
+ (UIViewController *)rootTopPresentedControllerWihtKeys:(NSArray<NSString *> *)keys {
    return [[[[UIApplication sharedApplication] delegate] window].rootViewController topPresentedControllerWihtKeys:keys];
}
- (UIViewController *)topPresentedController {
    return [self topPresentedControllerWihtKeys:nil];
}
- (UIViewController *)topPresentedControllerWihtKeys:(NSArray<NSString *> *)keys {
    keys = keys ?: @[@"centerViewController", @"contentViewController"];
    
    UIViewController *rootVC = self;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)rootVC;
        UIViewController *vc = tab.selectedViewController ?: tab.childViewControllers.firstObject;
        if (vc) {
            return [vc topPresentedControllerWihtKeys:keys];
        }
    }
    
    for (NSString *key in keys) {
        if ([rootVC respondsToSelector:NSSelectorFromString(key)]) {
            UIViewController *vc;
            @try {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                vc = [rootVC performSelector:NSSelectorFromString(key)];
#pragma clang diagnostic pop
            } @catch (NSException *exception) {
            }
            if ([vc isKindOfClass:[UIViewController class]]) {
                return [vc topPresentedControllerWihtKeys:keys];
            }
        }
    }
    
    while (rootVC.presentedViewController && !rootVC.presentedViewController.isBeingDismissed) {
        rootVC = rootVC.presentedViewController;
    }
    
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        rootVC = ((UINavigationController *)rootVC).topViewController;
    }
    
    return rootVC;
}

- (NSArray<UIViewController *> *)optimizeVcs:(NSArray<UIViewController *> *)vcs {
    return [self optimizeVcs:vcs maxCount:1];
}
- (NSArray<UIViewController *> *)optimizeVcs:(NSArray<UIViewController *> *)vcs maxCount:(NSUInteger)count {
    NSMutableArray *vcArray = [NSMutableArray arrayWithArray:vcs];
    [vcArray addObject:self];
    for (UIViewController *vc in vcArray.reverseObjectEnumerator) {
        if ([vc isKindOfClass:[self class]]) {
            if (count) {
                count--;
            }
            else {
                [vcArray removeObject:vc];
            }
        }
    }
    return vcArray.copy;
}

+ (instancetype)vcFromStoryBoard:(NSString *)sbName theId:(NSString *)theId
{
    sbName = sbName ?: [[self class] keyForNib];
    theId = theId ?: [[self class] keyForNib];
    UIStoryboard * story = [UIStoryboard storyboardWithName:sbName bundle:nil];
    UIViewController * viewCtrl = [story instantiateViewControllerWithIdentifier:theId];
    return viewCtrl;
}
+ (NSString *)keyForNib
{
    return NSStringFromClass([self class]);
}
@end
