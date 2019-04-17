//
//  ATHightlightButton.m
//  Postre
//
//  Created by 王炜圣 on 2017/4/6.
//  Copyright © 2017年 王炜圣. All rights reserved.
//

#import "ATHightlightButton.h"

static CGFloat ATHightlightButtonHighlightedAlpha = 0.49872f;
@interface ATHightlightButton() {
    CGFloat _originalAlpha;
}
@end
@implementation ATHightlightButton
+ (instancetype)buttonWithTarget:(id)target action:(SEL)action {
    return [self buttonWithImage:nil title:nil color:nil target:target action:action];
}
+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    return [self buttonWithTitle:title color:nil target:target action:action];
}
+ (instancetype)buttonWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    return [self buttonWithImage:image title:nil color:nil target:target action:action];
}
+ (instancetype)buttonWithTitle:(NSString *)title color:(UIColor *)color target:(id)target action:(SEL)action {
    return [self buttonWithImage:nil title:title color:color target:target action:action];
}
+ (instancetype)buttonWithImage:(UIImage *)image title:(NSString *)title color:(UIColor *)color target:(id)target action:(SEL)action {
    ATHightlightButton *button = [self buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (color) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    [button sizeToFit];
    return button;
}
+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    ATHightlightButton *button = [super buttonWithType:buttonType];
    if (button) {
        [button setup];
    }
    return button;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup {
    if ([self autoHighligted]) {
        self.adjustsImageWhenHighlighted = NO;
        self.reversesTitleShadowWhenHighlighted = NO;
        self.adjustsImageWhenDisabled = NO;
        
#define autoSetStateHighlighted(getter, setter) {\
        if ([super getter:UIControlStateSelected] != [super getter:UIControlStateNormal]) {\
            [super setter:[super getter:UIControlStateSelected]\
                   forState:UIControlStateSelected | UIControlStateHighlighted];\
        }\
        if ([super getter:UIControlStateDisabled] != [super getter:UIControlStateNormal]) {\
            [super setter:[super getter:UIControlStateDisabled]\
                   forState:UIControlStateDisabled | UIControlStateHighlighted];\
        }\
        if ([super getter:UIControlStateSelected|UIControlStateDisabled] != [super getter:UIControlStateNormal]) {\
            [super setter:[super getter:UIControlStateSelected|UIControlStateDisabled]\
                 forState:UIControlStateDisabled | UIControlStateHighlighted];\
        }\
    }
    
        autoSetStateHighlighted(titleForState, setTitle)
        autoSetStateHighlighted(imageForState, setImage)
        autoSetStateHighlighted(backgroundImageForState, setBackgroundImage)
        autoSetStateHighlighted(titleColorForState, setTitleColor)
        autoSetStateHighlighted(titleShadowColorForState, setTitleShadowColor)
    }
}

#define autoSynchronization(setter, type) \
- (void)setter:(type *)obj forState:(UIControlState)state {\
    [super setter:obj forState:state];\
    \
    if (UIButtonTypeCustom == self.buttonType\
        && !(state & UIControlStateHighlighted)\
        && (state & (UIControlStateDisabled | UIControlStateSelected))) {\
        [super setter:obj forState:state | UIControlStateHighlighted];\
    }\
}
autoSynchronization(setTitle, NSString)
autoSynchronization(setImage, UIImage)
autoSynchronization(setBackgroundImage, UIImage)
autoSynchronization(setTitleColor, UIColor)
autoSynchronization(setTitleShadowColor, UIColor)

- (BOOL)autoHighligted {
    return (UIButtonTypeCustom == self.buttonType
            && [super imageForState:UIControlStateHighlighted] == [super imageForState:UIControlStateNormal]
            && [super backgroundImageForState:UIControlStateHighlighted] == [super backgroundImageForState:UIControlStateNormal]
            && [super titleColorForState:UIControlStateHighlighted] == [super titleColorForState:UIControlStateNormal]
            && [super titleShadowColorForState:UIControlStateHighlighted] == [super titleShadowColorForState:UIControlStateNormal]);
}
- (BOOL)autoDisabled {
    return (UIButtonTypeCustom == self.buttonType
            && [super imageForState:UIControlStateDisabled] == [super imageForState:UIControlStateNormal]
            && [super backgroundImageForState:UIControlStateDisabled] == [super backgroundImageForState:UIControlStateNormal]
            && [super titleColorForState:UIControlStateDisabled] == [super titleColorForState:UIControlStateNormal]
            && [super titleShadowColorForState:UIControlStateDisabled] == [super titleShadowColorForState:UIControlStateNormal]);
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if ([self autoHighligted]) {
        if (ATHightlightButtonHighlightedAlpha != self.alpha) {
            _originalAlpha = self.alpha;
        }
        self.alpha = highlighted ? ATHightlightButtonHighlightedAlpha : _originalAlpha;
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if ([self autoDisabled]) {
        self.highlighted = !enabled;
    }
}
@end

@implementation ATBarButton
- (void)setup {
    [super setup];
    if ([UIBarButtonItem appearance].tintColor) {
        [self setTintColor:[UIBarButtonItem appearance].tintColor];
    }
    NSDictionary *dic = [[UIBarButtonItem appearance] titleTextAttributesForState:UIControlStateNormal];
    if (dic[NSForegroundColorAttributeName]) {
        [self setTitleColor:dic[NSForegroundColorAttributeName] forState:UIControlStateNormal];
    }
    else {
        [self setTitleColor:[UIColor colorWithRed:(0x44/255.0f) green:(0x44/255.0f) blue:(0x44/255.0f) alpha:1.0f] forState:UIControlStateNormal];
    }
    if (dic[NSFontAttributeName]) {
        [self.titleLabel setFont:dic[NSFontAttributeName]];
    }
    else {
        [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
    }
    _btnMinWidth = 30;
}
- (void)setIsRightItem:(BOOL)isRightItem {
    _isRightItem = isRightItem;
    [self setContentHorizontalAlignment:self.isRightItem ? UIControlContentHorizontalAlignmentRight : UIControlContentHorizontalAlignmentLeft];
}
- (CGSize)sizeThatFits:(CGSize)size {
    return [self intrinsicContentSize];
}
- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.height = 44;
    if (size.width < _btnMinWidth) {
        size.width = _btnMinWidth;
    }
    return size;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if ([self.superview.superview isKindOfClass:[UIStackView class]]) {
        if (self.superview.superview.subviews.count > 2) {
            ((UIStackView *)self.superview.superview).spacing = -4;
        }
    }
}
@end

@implementation ATCustomBarButton
- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += 44 * 2;
    return size;
}
- (CGSize)sizeThatFits:(CGSize)size {
    return [self intrinsicContentSize];
}
@end
