//
//  ATGridViewController.m
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2020/12/4.
//  Copyright © 2020 wangws1990. All rights reserved.
//

#import "ATGridViewController.h"
#import "ATCollectionViewCell.h"
#import "UICollectionViewCell+ATKit.h"
#import "UICollectionView+ATKit.h"
@interface ATGridViewController ()

@end

@implementation ATGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
//设置海报图片
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ATCollectionViewCell *cell = [ATCollectionViewCell cellForCollectionView:collectionView indexPath:indexPath];
    
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  [collectionView at_sizeForCellWithClassCell:ATCollectionViewCell.class indexPath:indexPath fixedValue:self.view.frame.size.width caculateType:ATDynamicTypeWidth config:^(__kindof UICollectionViewCell * cell) {
        
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
@end
