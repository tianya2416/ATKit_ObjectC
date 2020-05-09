//
//  ATMacro.m
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2019/4/30.
//  Copyright © 2019 wangws1990. All rights reserved.
//
#import "ATMacro.h"
#import <UIKit/UIKit.h>
@implementation ATMacro
+ (BOOL)iPad{
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}
+ (BOOL)iPhoneX{
    UIView *window = [UIApplication sharedApplication].delegate.window;
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets inset = window.safeAreaInsets;
        return (inset.bottom == 34) || (inset.bottom == 21);
    }
    return NO;
}
@end
