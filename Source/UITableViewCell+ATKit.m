//
//  UITableViewCell+ATKit.m
//  Postre
//
//  Created by 王炜圣 on 2017/4/6.
//  Copyright © 2017年 王炜圣. All rights reserved.
//

#import "UITableViewCell+ATKit.h"

@implementation UITableViewCell (ATKit)
+ (NSString *)nibName {
    return NSStringFromClass(self);
}
+ (CGFloat)cellHeight {
    return 48;
}

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    return [self cellForTableView:tableView indexPath:indexPath identifier:nil config:nil];
}
+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
                          config:(void (^NS_NOESCAPE)(__kindof UITableViewCell *cell))config {
    return [self cellForTableView:tableView indexPath:indexPath identifier:nil config:config];
}
+ (instancetype)cellForTableView:(UITableView *)tableView
                       indexPath:(NSIndexPath *)indexPath
                      identifier:(NSString *)identifier
                          config:(void (^NS_NOESCAPE)(__kindof UITableViewCell *cell))config {
    assert(indexPath);
    
    identifier = identifier ?: NSStringFromClass(self);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        // 通过判断是否存在xib文件
        if ([[NSBundle mainBundle] URLForResource:self.nibName withExtension:@"nib"]) {
            [tableView registerNib:[UINib nibWithNibName:self.nibName bundle:nil]
            forCellReuseIdentifier:identifier];
        }
        // 不是XIB
        else {
            [tableView registerClass:self.class forCellReuseIdentifier:identifier];
        }
        
        cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    }
    
    static NSInteger configTag = 32241981;
    if (cell.tag != configTag) {
        cell.tag = configTag;
        if (config) {
            config(cell);
        }
    }
    return cell;
}
@end
