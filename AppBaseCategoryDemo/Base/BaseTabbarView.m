//
//  BaseTabbarView.m
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import "BaseTabbarView.h"
#import "ATKit.h"
@interface BaseTabbarView()
@property (assign, nonatomic) id <BaseTabbarDelegate>delegate;
@property (strong, nonatomic) NSArray <UITabBarItem *>*tabbarItems;
@property (strong, nonatomic) NSMutableArray *listData;

@end
@implementation BaseTabbarView
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
  
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}
+ (instancetype)tabbar:(NSArray<UITabBarItem *> *)tabbarItems delegate:(id<BaseTabbarDelegate>)delegate{
    BaseTabbarView *vc = [[BaseTabbarView alloc] init];
    vc.tabbarItems = tabbarItems;
    vc.delegate = delegate;
    [vc loadUI];
    return vc;
}
- (void)loadUI{
    self.listData = @[].mutableCopy;
    [self.tabbarItems enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ATImageTopButton *button = [ATImageTopButton buttonWithImage:obj.image title:obj.title color:[UIColor colorWithWhite:0.8 alpha:1.0f] target:self action:@selector(buttonAction:)];
        button.tag = idx + 10000;
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [button setImage:obj.selectedImage forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        button.imageMarning = 10;
        button.selected = idx == 0;
        button.adjustsImageWhenHighlighted = NO;
        [self addSubview:button];
    }];
}
- (void)buttonAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(tabbarView:didSelect:)]) {
        [self.delegate tabbarView:self didSelect:sender.tag - 10000];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.tabbarItems.count;
    if (count > 0) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = [UIScreen mainScreen].bounds.size.width / count;
        CGFloat h = self.frame.size.height;
        for (int i = 0; i < count; i++) {
            UIButton *btn = [self viewWithTag:10000+i];
            x = i * w;
            if (i == 2) {
                y = -12;
                h = h + 12;
            } else {
                y = 0;
            }
            btn.frame = CGRectMake(x, y, w, h);
        }
    }
}

@end
