//
//  BaseConnectionController.h
//  MyCountDownDay
//
//  Created by wangws1990 on 2019/1/21.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseConnectionController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic)UICollectionView * collectionView;
@end

NS_ASSUME_NONNULL_END
