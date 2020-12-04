//
//  UICollectionView+ATKit.h
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2020/12/4.
//  Copyright © 2020 wangws1990. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ATDynamicType) {
   ATDynamicTypeSize = 0,
   ATDynamicTypeWidth,
   ATDynamicTypeHeight
};
NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (ATKit)

- (CGSize)at_sizeForCellWithClassCell:(Class)classCell
                             indexPath:(NSIndexPath *)indexPath
                            fixedValue:(CGFloat)fixedValue
                          caculateType:(ATDynamicType)caculateType
                                config:(void (^)(__kindof UICollectionViewCell *))config;

@end

NS_ASSUME_NONNULL_END
