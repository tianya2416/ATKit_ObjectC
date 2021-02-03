//
//  BaseTabbarView.m
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2019/6/5.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import "BaseTabbarView.h"
#import "ATKit.h"
#define defaultCenter 1
@interface BaseTabbarView()
@property (strong, nonatomic) NSArray <UITabBarItem *>*tabbarItems;
@property (strong, nonatomic) NSMutableArray *listData;
@property (strong, nonatomic) NSString *centerItem;
@property (assign, nonatomic) NSInteger selectIndex;
@end
@implementation BaseTabbarView

+ (instancetype)tabbar:(NSArray<UITabBarItem *> *)tabbarItems{
    return [BaseTabbarView tabbar:tabbarItems centerItem:nil];
}
+(instancetype)tabbar:(NSArray <UITabBarItem *>*)tabbarItems centerItem:(NSString * _Nullable)centerItem{
    BaseTabbarView *vc = [[BaseTabbarView alloc] init];
    vc.tabbarItems = tabbarItems;
    vc.centerItem = centerItem;
    [vc loadUI];
    return vc;
}
- (void)loadUI{
    self.selectIndex = 1;
    self.listData = @[].mutableCopy;
    [self.tabbarItems enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ATImageTopButton *button = [ATImageTopButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:obj.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setImage:obj.image forState:UIControlStateNormal];
        button.tag = idx;
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [button setImage:obj.selectedImage forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.imageMarning = 5;
        [self addSubview:button];
        [self.listData addObject:button];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }];
    if (self.centerItem) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = [UIImage imageNamed:self.centerItem];
        [self addSubview:imageV];
        UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
        imageV.userInteractionEnabled = true;
        [imageV addGestureRecognizer:tap];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        NSInteger index = self.tabbarItems.count/2;
        if (self.listData.count >index) {
            [self.listData insertObject:imageV atIndex:index];
        }
    }
    self.selectIndex = 0;
}
- (void)buttonAction:(UIButton *)sender{
    self.selectIndex = sender.tag;
}
- (void)clickAction{
    if ([self.tabbarDelegate respondsToSelector:@selector(tabbarView:click:)]) {
        [self.tabbarDelegate tabbarView:self click:true];
    }
}
- (void)setSelectIndex:(NSInteger)selectIndex{
    if (_selectIndex != selectIndex) {
        _selectIndex = selectIndex;
        [self.listData enumerateObjectsUsingBlock:^(UIButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:UIButton.class]) {
                obj.selected = selectIndex == obj.tag;
            }
        }];
        if ([self.tabbarDelegate respondsToSelector:@selector(tabbarView:index:)]) {
            [self.tabbarDelegate tabbarView:self index:_selectIndex];
        }
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.listData.count;
    if (count > 0) {
        __block CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = self.frame.size.width / count;
        CGFloat h = 49;
        [self.listData enumerateObjectsUsingBlock:^(UIButton  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            x = idx * w;
            if ([obj isKindOfClass:UIButton.class]) {
                obj.frame = CGRectMake(x, y, w, h);
            }else{
                obj.frame = CGRectMake(x, y - 20, w, h + 20);
            }
            [self bringSubviewToFront:obj];
        }];
    }
}

@end


