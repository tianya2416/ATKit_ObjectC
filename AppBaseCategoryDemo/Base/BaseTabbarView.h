//
//  BaseTabbarView.h
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class BaseTabbarView;

@protocol BaseTabbarDelegate <NSObject>

- (void)tabbarView:(BaseTabbarView *)tabbarView index:(NSInteger)index;
- (void)tabbarView:(BaseTabbarView *)tabbarView click:(BOOL)click;

@end

@interface BaseTabbarView : UITabBar
+(instancetype)tabbar:(NSArray <UITabBarItem *>*)tabbarItems;
//tabbarItems 需要偶数
+(instancetype)tabbar:(NSArray <UITabBarItem *>*)tabbarItems centerItem:(NSString * _Nullable)centerItem;
@property (assign, nonatomic) id<BaseTabbarDelegate>tabbarDelegate;
@end
NS_ASSUME_NONNULL_END
