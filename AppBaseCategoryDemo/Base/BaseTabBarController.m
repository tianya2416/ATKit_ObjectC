//
//  BaseTabBarController.m
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "ATKit.h"
@interface BaseTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) NSMutableArray *nvcDatas;
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.nvcDatas = @[].mutableCopy;
    [self loadUI];
}
- (void)loadUI{
    UIViewController *home = [[UIViewController alloc] init];
    home.view.backgroundColor = [UIColor whiteColor];
    [self vcName:home title:@"首页" imageNormal:@"tabBar_icon_schedule_default" selectedImageName:@"tabBar_icon_schedule"];
    
    UIViewController *customer = [[UIViewController alloc] init];
    [self vcName:customer title:@"客户" imageNormal:@"tabBar_icon_customer_default" selectedImageName:@"tabBar_icon_customer"];
    customer.view.backgroundColor = [UIColor whiteColor];
    UIViewController *insurance = [[UIViewController alloc] init];
    [self addPublishButton];
    [self vcName:insurance title:@"发布" imageNormal:@"" selectedImageName:@""];
    
    UIViewController *compare = [[UIViewController alloc] init];
    [self vcName:compare title:@"产品" imageNormal:@"tabBar_icon_contrast_default" selectedImageName:@"tabBar_icon_contrast"];
    compare.view.backgroundColor = [UIColor whiteColor];
    UIViewController *profile = [[UIViewController alloc]init];
    [self vcName:profile title:@"我的" imageNormal:@"tabBar_icon_mine_default" selectedImageName:@"tabBar_icon_mine"];
    profile.view.backgroundColor = [UIColor whiteColor];
    self.viewControllers = self.nvcDatas.copy;

}
- (void)buttonClickAction{
    
}
- (void)vcName:(UIViewController *)childVc title:(NSString *)title imageNormal:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    // 设置标题
    childVc.tabBarItem.title = title;
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 不要渲染
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    // 添加为tabbar控制器的子控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    [self.nvcDatas addObject:nav];
}
#pragma UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return ![viewController.title isEqualToString:@"发布"];
}
//添加中间按钮
- (void)addPublishButton
{
    UIImage *image = [UIImage imageNamed:@"tabBar_publish_icon"];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClickAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    CGPoint center = self.tabBar.center;
    center.y = center.y - 15 - (iPhone_X ? 32 : 0);
    button.center = center;
    [self.view addSubview:button];
}
@end
