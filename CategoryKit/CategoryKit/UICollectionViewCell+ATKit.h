//
//  UICollectionViewCell+ATKit.h
//  Postre
//
//  Created by 王炜圣 on 2017/4/6.
//  Copyright © 2017年 王炜圣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ATKit.h"

@interface UICollectionViewCell (ATKit)

+ (instancetype)cellForCollectionView:(UICollectionView *)collectionView
                            indexPath:(NSIndexPath *)indexPath;
+ (instancetype)cellForCollectionView:(UICollectionView *)collectionView
                            indexPath:(NSIndexPath *)indexPath
                               config:(void (^NS_NOESCAPE)(__kindof UICollectionViewCell *cell))config;
+ (instancetype)cellForCollectionView:(UICollectionView *)collectionView
                            indexPath:(NSIndexPath *)indexPath
                           identifier:(NSString *)identifier
                               config:(void (^NS_NOESCAPE)(__kindof UICollectionViewCell *cell))config;
@end

@interface UICollectionReusableView (ATKit)
+ (instancetype)viewForCollectionView:(UICollectionView *)collectionView
                          elementKind:(NSString *)elementKind
                            indexPath:(NSIndexPath *)indexPath;
+ (instancetype)viewForCollectionView:(UICollectionView *)collectionView
                          elementKind:(NSString *)elementKind
                            indexPath:(NSIndexPath *)indexPath
                               config:(void (^NS_NOESCAPE)(__kindof UICollectionReusableView *view))config;
+ (instancetype)viewForCollectionView:(UICollectionView *)collectionView
                          elementKind:(NSString *)elementKind
                            indexPath:(NSIndexPath *)indexPath
                           identifier:(NSString *)identifier
                               config:(void (^NS_NOESCAPE)(__kindof UICollectionReusableView *view))config;

@property (nonatomic, copy) void(^tapBlock)(__kindof UICollectionReusableView *view);
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@end
