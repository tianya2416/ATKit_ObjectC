//
//  ATMacro.m
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2019/4/30.
//  Copyright © 2019 wangws1990. All rights reserved.
//
#import "ATMacro.h"
#import <UIKit/UIKit.h>
#define AT_Phone_X            [ATMacro at_iphonex]
@implementation ATMacro
+ (BOOL)iPhone{
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}
+ (BOOL)at_iphonex{
    UIView *window = [UIApplication sharedApplication].delegate.window;
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets inset = window.safeAreaInsets;
        return ((inset.bottom == 34) || (inset.bottom == 21)) &&[ATMacro iPhone] ;
    }
    return NO;
}
/// iPhone_X 44,other 20
+ (CGFloat)at_status_bar{
    return  AT_Phone_X ? 44 : 20;
}

/// iPhone_X 88,other 64
+ (CGFloat)at_navi_bar{
    return  AT_Phone_X ? 88 : 64;
}

/// iPhone_X 34,other 0
+ (CGFloat)at_tab_bar{
    return  AT_Phone_X ? 34 : 0;
}
@end
