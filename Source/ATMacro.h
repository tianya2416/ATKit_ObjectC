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

#define SCALEW(value)       ((CGFloat)((SCREEN_WIDTH * (value) / 375.0f)))

#define iPhone_X            [ATMacro phone_x]//is iPhone_X
#define STATUS_BAR_HIGHT    (iPhone_X ? 44: 20)//iPhone_X 44,other 20
#define NAVI_BAR_HIGHT      (iPhone_X ? 88: 64)//iPhone_X 88,other 64
#define TAB_BAR_ADDING      (iPhone_X ? 34 : 0)//iPhone_X 34,other 0


NS_ASSUME_NONNULL_BEGIN

@interface ATMacro : NSObject
+ (BOOL)phone_x;
@end

NS_ASSUME_NONNULL_END
