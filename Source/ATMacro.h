//
//  ATMacro.h
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2019/4/30.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SCREEN_WIDTH (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))
#define SCREEN_HEIGHT (MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))

#define SCALEW(value)      ((CGFloat)((SCREEN_WIDTH * (value) / 375.0f)))

#define iPhoneX             [ATMacro iPhone_X]//is iPhoneX
#define STATUS_BAR_HIGHT    (iPhoneX ? 44: 20)//iPhoneX 44,other 20
#define NAVI_BAR_HIGHT      (iPhoneX ? 88: 64)//iPhoneX 88,other 64
#define TAB_BAR_ADDING      (iPhoneX ? 34 : 0)//iphoneX 34,other 0


NS_ASSUME_NONNULL_BEGIN

@interface ATMacro : NSObject

+ (BOOL)iPad;
+ (BOOL)iPhone_X;

@end

NS_ASSUME_NONNULL_END
