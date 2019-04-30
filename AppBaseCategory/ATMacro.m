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
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && ![ATMacro iPad] : NO);
}
+ (BOOL)iPhoneXR{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && ![ATMacro iPad] : NO);
}
+ (BOOL)iPhoneXMax{
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& ![ATMacro iPad] : NO);
}
@end
