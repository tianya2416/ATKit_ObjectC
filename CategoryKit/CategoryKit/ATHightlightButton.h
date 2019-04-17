//
//  ATHightlightButton.h
//  Postre
//
//  Created by 王炜圣 on 2017/4/6.
//  Copyright © 2017年 王炜圣. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 默认按键按下时, 透明度降低
 */
@interface ATHightlightButton : UIButton
- (void)setup NS_REQUIRES_SUPER;

+ (instancetype)buttonWithTarget:(id)target action:(SEL)action;
+ (instancetype)buttonWithImage:(UIImage *)image target:(id)target action:(SEL)action;
+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (instancetype)buttonWithTitle:(NSString *)title color:(UIColor *)color target:(id)target action:(SEL)action;
+ (instancetype)buttonWithImage:(UIImage *)image title:(NSString *)title color:(UIColor *)color target:(id)target action:(SEL)action;
@end

@interface ATBarButton : ATHightlightButton
@property (nonatomic, assign) CGFloat btnMinWidth;
@property (nonatomic, assign) BOOL isRightItem;
@end
@interface ATCustomBarButton : ATBarButton
@end
