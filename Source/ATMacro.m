//
//  ATMacro.m
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2019/4/30.
//  Copyright © 2019 wangws1990. All rights reserved.
//
#import "ATMacro.h"
#import <UIKit/UIKit.h>
#define at_inset       [UIApplication sharedApplication].delegate.window.safeAreaInsets
@implementation ATMacro
+ (BOOL)iPhone{
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}
+ (BOOL)at_iphoneX{
    if (@available(iOS 11.0, *)) {
        return at_inset.bottom > 0 ? true : false;  //34 or 21
    }
    return NO;
}
// iPhone_X more 44,other equal 20
+ (CGFloat)at_statusBar{
    if (@available(iOS 11.0, *)) {
        return at_inset.top;
    }
    return 20;
}
/// iPhone_X 34,other 0
+ (CGFloat)at_tabBar{
    if (@available(iOS 11.0, *)) {
        return at_inset.bottom;
    }
    return 0;
}
/// iPhone_X 88,other 64
+ (CGFloat)at_naviBar{
    return  (44 + [ATMacro at_statusBar]);
}

//    if (@available(iOS 13.0, *)) {
//        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].keyWindow.windowScene.statusBarManager;
//        return  statusBarManager.statusBarFrame.size.height;
//    } else {
//        return  [UIApplication sharedApplication].statusBarFrame.size.height;
//    }
@end
