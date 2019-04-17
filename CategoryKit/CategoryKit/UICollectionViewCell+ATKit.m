//
//  UICollectionViewCell+ATKit.m
//  Postre
//
//  Created by 王炜圣 on 2017/4/6.
//  Copyright © 2017年 王炜圣. All rights reserved.
//

#import "UICollectionViewCell+ATKit.h"
#import <objc/runtime.h>

@implementation UICollectionViewCell (ATKit)

+ (instancetype)cellForCollectionView:(UICollectionView *)collectionView
                            indexPath:(NSIndexPath *)indexPath {
    return [self cellForCollectionView:collectionView
                             indexPath:indexPath
                            identifier:nil
                                config:nil];
}
+ (instancetype)cellForCollectionView:(UICollectionView *)collectionView
                            indexPath:(NSIndexPath *)indexPath
                               config:(void (^)(__kindof UICollectionViewCell *))config {
    return [self cellForCollectionView:collectionView
                             indexPath:indexPath
                            identifier:nil
                                config:config];
}
+ (instancetype)cellForCollectionView:(UICollectionView *)collectionView
                            indexPath:(NSIndexPath *)indexPath
                           identifier:(NSString *)identifier
                               config:(void (^)(__kindof UICollectionViewCell *))config {
    assert(indexPath);
    
    identifier = identifier ?: NSStringFromClass(self);
    
    BOOL hasRegister = [[collectionView valueForKeyPath:@"cellNibDict"] valueForKeyPath:identifier]
    || [[collectionView valueForKeyPath:@"cellClassDict"] valueForKeyPath:identifier];
    
    if (!hasRegister) {
        // 通过判断是否存在xib文件
        if ([[NSBundle mainBundle] URLForResource:self.nibName withExtension:@"nib"]) {
            [collectionView registerNib:[UINib nibWithNibName:self.nibName bundle:nil]
             forCellWithReuseIdentifier:identifier];
        }
        // 不是XIB
        else {
            [collectionView registerClass:self.class forCellWithReuseIdentifier:identifier];
        }
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                           forIndexPath:indexPath];
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

@implementation UICollectionReusableView (ATKit)
+ (instancetype)viewForCollectionView:(UICollectionView *)collectionView
                          elementKind:(NSString *)elementKind
                            indexPath:(NSIndexPath *)indexPath {
    return [self viewForCollectionView:collectionView
                           elementKind:(NSString *)elementKind
                             indexPath:indexPath
                            identifier:nil
                                config:nil];
}
+ (instancetype)viewForCollectionView:(UICollectionView *)collectionView
                          elementKind:(NSString *)elementKind
                            indexPath:(NSIndexPath *)indexPath
                               config:(void (^NS_NOESCAPE)(__kindof UICollectionReusableView *view))config {
    return [self viewForCollectionView:collectionView
                           elementKind:(NSString *)elementKind
                             indexPath:indexPath
                            identifier:nil
                                config:config];
}
+ (instancetype)viewForCollectionView:(UICollectionView *)collectionView
                          elementKind:(NSString *)elementKind
                            indexPath:(NSIndexPath *)indexPath
                           identifier:(NSString *)identifier
                               config:(void (^NS_NOESCAPE)(__kindof UICollectionReusableView *view))config {
    assert(indexPath);
    assert(elementKind);
    
    identifier = identifier ?: NSStringFromClass(self);
    NSString *keyPath = [elementKind stringByAppendingFormat:@"/%@", identifier];
    BOOL hasRegister = [[collectionView valueForKeyPath:@"supplementaryViewNibDict"] valueForKeyPath:keyPath]
    || [[collectionView valueForKeyPath:@"supplementaryViewClassDict"] valueForKeyPath:keyPath];
    
    if (!hasRegister) {
        // 通过判断是否存在xib文件
        if ([[NSBundle mainBundle] URLForResource:self.nibName withExtension:@"nib"]) {
            [collectionView registerNib:[UINib nibWithNibName:self.nibName bundle:nil] forSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier];
        }
        // 不是XIB
        else {
            [collectionView registerClass:self.class forSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier];
        }
    }
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier forIndexPath:indexPath];
    static NSInteger configTag = 32241981;
    if (view.tag != configTag) {
        view.tag = configTag;
        if (config) {
            config(view);
        }
    }
    
    return view;
}

- (void)setTapBlock:(void (^)(__kindof UICollectionReusableView *))tapBlock {
    [self willChangeValueForKey:@"tapBlock"];
    objc_setAssociatedObject(self, _cmd, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (self.tapBlock) {
        self.tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    }
    else {
        self.tap = nil;
    }
    [self didChangeValueForKey:@"tapBlock"];
}
- (void)tapAction:(UITapGestureRecognizer *)sender{
    UICollectionReusableView *view = (UICollectionReusableView *)sender.view;
    !self.tapBlock ?: self.tapBlock(view);
}
- (void (^)(__kindof UICollectionReusableView *))tapBlock {
    return objc_getAssociatedObject(self, @selector(setTapBlock:));
}
- (void)setTap:(UITapGestureRecognizer *)tap {
    [self willChangeValueForKey:@"tap"];
    if (self.tap) {
        [self removeGestureRecognizer:self.tap];
    }
    objc_setAssociatedObject(self, _cmd, tap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.tap) {
        [self addGestureRecognizer:self.tap];
    }
    [self didChangeValueForKey:@"tap"];
}
- (UITapGestureRecognizer *)tap {
    return objc_getAssociatedObject(self, @selector(setTap:));
}
@end
