//
//  UIView+Base.h
//  Postre
//
//  Created by 王炜圣 on 2017/4/6.
//  Copyright © 2017年 王炜圣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Base)
+ (NSString *)nibName;
+ (instancetype)instanceView;
/**
 Returns the topMost UIViewController object in hierarchy.
 */
@property (nonatomic, readonly, strong) UIViewController *topMostController;

/**
 Returns the superView of provided class type.
 */
- (__kindof UIView *)superviewOfClass:(Class)classType;

/**
 Returns the navigationController, if exsit.
 */
@property (nonatomic, readonly, strong) UINavigationController *getNavigationController;

/**
 Returns the findFirstResponder, self or subview, if exsit.
 */
- (UIView *)findFirstResponder;
@end
