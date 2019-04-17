//
//  UIView+Base.m
//  Postre
//
//  Created by 王炜圣 on 2017/4/6.
//  Copyright © 2017年 王炜圣. All rights reserved.
//

#import "UIView+ATKit.h"

@implementation UIView (Base)
+ (NSString *)nibName {
    return NSStringFromClass(self);
}
+ (instancetype)instanceView {
    UIView *view = [[NSBundle mainBundle] loadNibNamed:self.nibName owner:nil options:nil].firstObject;
    return view ?: self.new;
}

- (UIViewController *)topMostController
{
    NSMutableArray *controllersHierarchy = [[NSMutableArray alloc] init];
    
    UIViewController *topController = self.window.rootViewController;
    
    if (topController)
    {
        [controllersHierarchy addObject:topController];
    }
    
    while ([topController presentedViewController]) {
        
        topController = [topController presentedViewController];
        [controllersHierarchy addObject:topController];
    }
    
    UIResponder *matchController = [self viewController];
    
    while (matchController != nil && [controllersHierarchy containsObject:matchController] == NO)
    {
        do
        {
            matchController = [matchController nextResponder];
            
        } while (matchController != nil && [matchController isKindOfClass:[UIViewController class]] == NO);
    }
    
    return (UIViewController*)matchController;
}

- (UIView*)superviewOfClass:(Class)classType
{
    UIView *superview = self.superview;
    
    while (superview)
    {
        static Class UITableViewCellScrollViewClass = Nil;   //UITableViewCell
        static Class UITableViewWrapperViewClass = Nil;      //UITableViewCell
        static Class UIQueuingScrollViewClass = Nil;         //UIPageViewController
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            UITableViewCellScrollViewClass      = NSClassFromString(@"UITableViewCellScrollView");
            UITableViewWrapperViewClass         = NSClassFromString(@"UITableViewWrapperView");
            UIQueuingScrollViewClass            = NSClassFromString(@"_UIQueuingScrollView");
        });
        if ([superview isKindOfClass:classType] &&
            ([superview isKindOfClass:UITableViewCellScrollViewClass] == NO) &&
            ([superview isKindOfClass:UITableViewWrapperViewClass] == NO) &&
            ([superview isKindOfClass:UIQueuingScrollViewClass] == NO))
        {
            return superview;
        }
        else    superview = superview.superview;
    }
    
    return nil;
}
- (UINavigationController *)getNavigationController {
    UIView *view = self.superview;
    while(view) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)nextResponder;
        }
        view = view.superview;
    }
    return nil;
}

- (UIView *)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}
- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end

