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

#define SCALEW(value) ((CGFloat)((SCREEN_WIDTH * (value) / 375.0f)))

#define iPhone_X    [ATMacro iPhoneX]
#define iPhone_XR   [ATMacro iPhoneXR]
#define iPhone_XMax [ATMacro iPhoneXMax]
#define iPhone_Bang (iPhone_X  || iPhone_XR || iPhone_XMax)

#define STATUS_BAR_HIGHT    (iPhone_Bang ? 44: 20)//状态栏
#define NAVI_BAR_HIGHT      (iPhone_Bang ? 88: 64)//导航栏
#define TAB_BAR_ADDING      (iPhone_Bang ? 34 : 0)//iphoneX斜刘海


NS_ASSUME_NONNULL_BEGIN

@interface ATMacro : NSObject
+ (BOOL)iPad;
+ (BOOL)iPhoneX;
+ (BOOL)iPhoneXR;
+ (BOOL)iPhoneXMax;
@end

NS_ASSUME_NONNULL_END
