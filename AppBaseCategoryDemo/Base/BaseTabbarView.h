//
//  BaseTabbarView.h
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseTabbarView;
NS_ASSUME_NONNULL_BEGIN
@protocol BaseTabbarDelegate <NSObject>

- (void)tabbarView:(BaseTabbarView *)tabbarView didSelect:(NSInteger)didSelect;

@end
@interface BaseTabbarView : UIView
+(instancetype)tabbar:(NSArray <UITabBarItem *>*)tabbarItems delegate:(id <BaseTabbarDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
