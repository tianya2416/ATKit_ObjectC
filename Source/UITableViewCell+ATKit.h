//
//  UITableViewCell+ATKit.h
//  Postre
//
//  Created by wangws1990 on 2017/4/6.
//  Copyright © 2017年 wangws1990. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ATKit.h"

@interface UITableViewCell (ATKit)
+ (CGFloat)cellHeight;

+ (instancetype)cellForTableView:(UITableView *)tableView
                       indexPath:(NSIndexPath *)indexPath;
+ (instancetype)cellForTableView:(UITableView *)tableView
                       indexPath:(NSIndexPath *)indexPath
                          config:(void (^NS_NOESCAPE)(__kindof UITableViewCell *cell))config;
+ (instancetype)cellForTableView:(UITableView *)tableView
                       indexPath:(NSIndexPath *)indexPath
                      identifier:(NSString *)identifier
                          config:(void (^NS_NOESCAPE)(__kindof UITableViewCell *cell))config;
@end
