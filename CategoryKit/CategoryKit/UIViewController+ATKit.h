//
//  UIViewController+ATKit.h
//  Postre
//
//  Created by wangws1990 on 2019/4/16.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ATKit)
/**
 *  设置导航栏标题
 */
- (void)setNavItemTitle:(NSString *)title;
- (void)setBackItem:(UIImage *)image;
- (void)setBackItem:(UIImage *)image closeItem:(UIImage *)closeImage;
- (void)showNavTitle:(NSString *)title backItem:(BOOL)show;
- (void)setKeyBoardDismiss;
/**
 @brief  设置小导航栏
 */
- (void)setLargeTitleDisplayModeNever;

/**
 *  导航栏 按钮，color为空时，标示默认颜色
 */
- (UIBarButtonItem *)navItemWithImage:(UIImage *)image action:(SEL)action;
- (UIBarButtonItem *)navItemWithTitle:(NSString *)title action:(SEL)action;
- (UIBarButtonItem *)navItemWithTitle:(NSString *)title color:(UIColor *)color action:(SEL)action;
- (UIBarButtonItem *)navItemWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action;
- (UIBarButtonItem *)navItemWithImage:(UIImage *)image title:(NSString *)title color:(UIColor *)color action:(SEL)action;
- (UIBarButtonItem *)navItemWithImage:(UIImage *)image title:(NSString *)title color:(UIColor *)color target:(id)target action:(SEL)action;

- (void)setNavRightItemWithImage:(UIImage *)image action:(SEL)action;
- (void)setNavRightItemWithTitle:(NSString *)title action:(SEL)action;
- (void)setNavRightItemWithTitle:(NSString *)title color:(UIColor *)color action:(SEL)action;
- (void)setNavRightItemWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action;
- (void)setNavRightItemWithImage:(UIImage *)image title:(NSString *)title color:(UIColor *)color action:(SEL)action;

/**
 *  返回上一个界面
 */
- (void)goBack;
- (void)goBack:(BOOL)animated;
- (void)dismissOrPopToRootControlelr;
- (void)dismissOrPopToRootController:(BOOL)animated;

/**
 *  获取根目录
 */
- (UIViewController *)topPresentedController;
- (UIViewController *)topPresentedControllerWihtKeys:(NSArray<NSString *> *)keys;
+ (UIViewController *)rootTopPresentedController;
+ (UIViewController *)rootTopPresentedControllerWihtKeys:(NSArray<NSString *> *)keys;

/**
 *  控制器数组中 仅存在一个实例
 */
- (NSArray<UIViewController *> *)optimizeVcs:(NSArray<UIViewController *> *)vcs;
- (NSArray<UIViewController *> *)optimizeVcs:(NSArray<UIViewController *> *)vcs maxCount:(NSUInteger)count;
/**
 *  StoryBoard 创建
 */
+ (instancetype)vcFromStoryBoard:(NSString *)sbName theId:(NSString *)theId;
@end
