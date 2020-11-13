//
//  ATMacro.h
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2019/4/30.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define SCREEN_WIDTH (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))
#define SCREEN_HEIGHT (MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))

#define SCALEW(value)       ((CGFloat)((SCREEN_WIDTH * (value) / 375.0f)))

#define iPhone_X            [ATMacro at_iphoneX]
#define STATUS_BAR_HIGHT    [ATMacro at_statusBar]
#define NAVI_BAR_HIGHT      [ATMacro at_naviBar]
#define TAB_BAR_ADDING      [ATMacro at_tabBar]


NS_ASSUME_NONNULL_BEGIN

@interface ATMacro : NSObject

+ (BOOL)at_iphoneX;

/// iPhone_X 44,other 20
+ (CGFloat)at_statusBar;

/// iPhone_X 88,other 64
+ (CGFloat)at_naviBar;

/// iPhone_X 34,other 0
+ (CGFloat)at_tabBar;

@end

NS_ASSUME_NONNULL_END
