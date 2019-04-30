//
//  BaseNavigationController.m
//  MyCountDownDay
//
//  Created by wangws1990 on 2019/1/21.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL pushing;

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}
#pragma mark UINavigationControllerDelegate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.pushing == YES) {
        NSLog(@"被拦截");
        return;
    } else {
        NSLog(@"push");
        self.pushing = YES;
    }
    [super pushViewController:viewController animated:animated];
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.pushing = NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
@end
