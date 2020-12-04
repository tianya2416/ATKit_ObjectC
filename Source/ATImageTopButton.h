//
//  ATImageTopButton.h
//  Postre
//
//  Created by wangws1990 on 2017/4/6.
//  Copyright © 2017年 wangws1990. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATHightlightButton.h"

typedef NS_ENUM(NSInteger, UIButtonImagePosition) {
    UIBUttonImagePositionLeft,
    UIBUttonImagePositionRight,
    UIBUttonImagePositionTop,
    UIBUttonImagePositionBottom,
};

@interface UIButton (ImagePosition)
- (void)setImagePosition:(UIButtonImagePosition)postion spaceToTitle:(CGFloat)space;
@end


@interface ATImageTopButton : ATHightlightButton
@property (nonatomic, assign) IBInspectable CGFloat imageMarning;

@end

@interface ATImageRightButton : ATHightlightButton
@property (nonatomic, assign) IBInspectable CGFloat imageMarning;
@end

@interface ATMargingButton : ATHightlightButton
@property (nonatomic, assign) IBInspectable CGFloat imageMarning;
@end

@interface ATBorderButton : ATMargingButton
@end
