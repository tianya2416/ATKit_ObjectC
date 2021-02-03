//
//  BaseTabBarController.m
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "ViewController.h"
#import "ATKit.h"
#import "BaseTabbarView.h"
@interface BaseTabBarController ()<UITabBarControllerDelegate,BaseTabbarDelegate>
@property (nonatomic, strong) NSMutableArray *nvcDatas;

@property (nonatomic, strong) BaseTabbarView *tabbarView;
@end

@implementation BaseTabBarController
- (BaseTabbarView *)tabbarView{
    if (!_tabbarView) {
        UITabBarItem *item1 = [self item:@"首页" :@"tabBar_icon_contrast_default" :@"tabBar_icon_contrast" :ViewController.new];
        //UITabBarItem *item2 = [self item:@"发现" :@"tabBar_publish_icon" :@"tabBar_publish_icon" :BaseViewController.new];
        UITabBarItem *item3 = [self item:@"我的" :@"tabBar_icon_mine_default" :@"tabBar_icon_mine" :BaseViewController.new];
        _tabbarView = [BaseTabbarView tabbar:@[item1,item3] centerItem:@"tabBar_publish_icon"];
        _tabbarView.tabbarDelegate =self;
    }
    return _tabbarView;
}
- (UITabBarItem *)item:(NSString *)title :(NSString *)image :(NSString *)selectedImage :controller{
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectedImage]];
    [self vcName:controller title:title];
    return  item;
}
- (void)vcName:(UIViewController *)childVc title:(NSString *)title{
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    [childVc showNavTitle:title];
    [self.nvcDatas addObject:nav];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.nvcDatas = @[].mutableCopy;
    [self loadUI];
}
- (void)loadUI{
    [self setValue:self.tabbarView forKey:@"tabBar"];
    self.viewControllers = self.nvcDatas;
}
#pragma UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

}
- (void)buttonClickAction{
    UIViewController *customer = [[BaseViewController alloc] init];
    BaseNavigationController *nvc = [[BaseNavigationController alloc] initWithRootViewController:customer];
    [UIViewController.rootTopPresentedController presentViewController:nvc animated:true completion:nil];
}

#pragma mark BaseTabbarDelegate
- (void)tabbarView:(BaseTabbarView *)tabbarView index:(NSInteger)index{
    self.selectedIndex = index;
}
- (void)tabbarView:(BaseTabbarView *)tabbarView click:(BOOL)click{
    [self buttonClickAction];
}
@end
