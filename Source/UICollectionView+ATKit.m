//
//  UICollectionView+ATKit.m
//  AppBaseCategoryDemo
//
//  Created by wangws1990 on 2020/12/4.
//  Copyright © 2020 wangws1990. All rights reserved.
//

#import "UICollectionView+ATKit.h"
#import "UICollectionViewCell+ATKit.h"
#import <objc/runtime.h>

#define ATSizeZeroValue [NSValue valueWithCGSize:CGSizeZero]

@implementation UICollectionView (ATKit)
+ (void)load {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [self swizzlingMethods];
  });
}
+ (void)swizzlingMethods {
  SEL selectors[] = {
    @selector(reloadData),
    @selector(reloadSections:),
    @selector(deleteSections:),
    @selector(moveSection:toSection:),
    @selector(reloadItemsAtIndexPaths:),
    @selector(deleteItemsAtIndexPaths:),
    @selector(moveItemAtIndexPath:toIndexPath:)
  };

  for (int i = 0; i < sizeof(selectors) / sizeof(SEL); i++) {
    SEL originalSelector = selectors[i];
    SEL swizzledSelector = NSSelectorFromString([@"at_"
        stringByAppendingString:NSStringFromSelector(originalSelector)]);

    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);

    method_exchangeImplementations(originalMethod, swizzledMethod);
  }
}

- (CGSize)at_sizeForCellWithClassCell:(Class )classCell
                             indexPath:(NSIndexPath *)indexPath
                            fixedValue:(CGFloat)fixedValue
                          caculateType:(ATDynamicType)caculateType
                                config:(void (^)(__kindof UICollectionViewCell *))config{
    BOOL hasCache = [self hasCacheAtIndexPath:indexPath];
    if (hasCache) {
      if (![[self sizeCacheAtIndexPath:indexPath]
              isEqualToValue:ATSizeZeroValue]) {
        return [[self sizeCacheAtIndexPath:indexPath] CGSizeValue];
      }
    }
    // has no size chche
    UICollectionViewCell *cell =[self templeCaculateCellWithIdentifier:classCell];
    !config ?: config(cell);
    CGSize size = CGSizeMake(fixedValue, fixedValue);
    if (caculateType != ATDynamicTypeSize) {
      NSLayoutAttribute attribute = caculateType == ATDynamicTypeWidth
                                        ? NSLayoutAttributeWidth
                                        : NSLayoutAttributeHeight;
      NSLayoutConstraint *tempConstraint =
          [NSLayoutConstraint constraintWithItem:cell.contentView
                                       attribute:attribute
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:nil
                                       attribute:NSLayoutAttributeNotAnAttribute
                                      multiplier:1
                                        constant:fixedValue];
      [cell.contentView addConstraint:tempConstraint];
      size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
      [cell.contentView removeConstraint:tempConstraint];
    } else {
      size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    }
    if ([self sizeCache].count > indexPath.section) {
        NSMutableArray *sectionCache = [self sizeCache][indexPath.section];
        NSValue *sizeValue = [NSValue valueWithCGSize:size];
        if (hasCache) {
          [sectionCache replaceObjectAtIndex:indexPath.row withObject:sizeValue];
        } else {
          [sectionCache insertObject:sizeValue atIndex:indexPath.row];
        }
    }
    return size;
}

#pragma mark - cell cache
- (NSMutableDictionary *)templeCells {
  NSMutableDictionary *templeCells = objc_getAssociatedObject(self, _cmd);
  if (templeCells == nil) {
    templeCells = @{}.mutableCopy;
    objc_setAssociatedObject(self, _cmd, templeCells,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  return templeCells;
}
- (UICollectionViewCell *)templeCaculateCellWithIdentifier:(Class)classCell {
   
    NSString *identifier = NSStringFromClass(classCell);
    if ([classCell respondsToSelector:@selector(cellForRegister:identifier:)]) {
        identifier = [classCell cellForRegister:self identifier:identifier];
    }
    NSMutableDictionary *templeCells = [self templeCells];
    id cell = [templeCells objectForKey:identifier];
    if (cell == nil) {
      NSDictionary *cellNibDict = [self valueForKey:@"_cellNibDict"];
      UINib *cellNIb = cellNibDict[identifier];
      cell = [[cellNIb instantiateWithOwner:nil options:nil] lastObject];
      templeCells[identifier] = cell;
    }
    return cell;
}

#pragma mark - cache methods
- (NSMutableArray *)sizeCache {
  NSMutableArray *cache = objc_getAssociatedObject(self, _cmd);
  if (cache == nil) {
    cache = @[].mutableCopy;
    objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN);
  }
  return cache;
}
- (BOOL)hasCacheAtIndexPath:(NSIndexPath *)indexPath {
  BOOL hasCache = NO;
  NSMutableArray *cacheArray = [self sizeCache];
  if (cacheArray.count > indexPath.section) {
    if ([cacheArray[indexPath.section] count] > indexPath.row) {
      hasCache = YES;
    }
  } else {
    NSUInteger index = cacheArray.count;
    for (; index < indexPath.section + 1; index++) {
      [cacheArray addObject:@[].mutableCopy];
    }
  }

  return hasCache;
}
- (NSValue *)sizeCacheAtIndexPath:(NSIndexPath *)indexPath {
  NSValue *sizeValue = [self sizeCache][indexPath.section][indexPath.row];
  return sizeValue;
}


#pragma mark - section changes
- (void)at_reloadSections:(NSIndexSet *)sections {
  [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
    if (idx < [self sizeCache].count) {
      [[self sizeCache] replaceObjectAtIndex:idx withObject:@[].mutableCopy];
    }
  }];
  [self at_reloadSections:sections];
}

- (void)at_deleteSections:(NSIndexSet *)sections {
  [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
    if (idx < [self sizeCache].count) {
      [[self sizeCache] removeObjectAtIndex:idx];
    }
  }];
  [self at_deleteSections:sections];
}

- (void)at_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    if (section < [self sizeCache].count && newSection < [self sizeCache].count) {
      [[self sizeCache] exchangeObjectAtIndex:section withObjectAtIndex:newSection];
    }
  [self at_moveSection:section toSection:newSection];
}

#pragma mark - item changes
- (void)at_deleteItemsAtIndexPaths:(NSArray *)indexPaths {
  [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx,
                                           BOOL *stop) {
    if ([self.sizeCache count] > obj.section) {
      NSMutableArray *section = [self sizeCache][obj.section];
      [section removeObjectAtIndex:obj.row];
    }
  }];
  [self at_deleteItemsAtIndexPaths:indexPaths];
}
- (void)at_reloadItemsAtIndexPaths:(NSArray *)indexPaths {
  [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx,
                                           BOOL *stop) {
    if ([self.sizeCache count] > obj.section) {
      NSMutableArray *section = [self sizeCache][obj.section];
      section[obj.row] = ATSizeZeroValue;
    }
  }];
  [self at_reloadItemsAtIndexPaths:indexPaths];
}

- (void)at_moveItemAtIndexPath:(NSIndexPath *)indexPath
                   toIndexPath:(NSIndexPath *)newIndexPath {
  if ([self hasCacheAtIndexPath:indexPath] &&
      [self hasCacheAtIndexPath:newIndexPath]) {
      NSValue *indexPathSizeValue = [self sizeCacheAtIndexPath:indexPath];
      NSValue *newIndexPathSizeValue = [self sizeCacheAtIndexPath:newIndexPath];
      if ([self sizeCache].count > indexPath.section && [self sizeCache].count > newIndexPath.section) {
          NSMutableArray *section1 = [self sizeCache][indexPath.section];
          NSMutableArray *section2 = [self sizeCache][newIndexPath.section];
          [section1 replaceObjectAtIndex:indexPath.row
                              withObject:newIndexPathSizeValue];
          [section2 replaceObjectAtIndex:newIndexPath.row
                              withObject:indexPathSizeValue];
      }
  }
  [self at_moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
}

- (void)at_reloadData {
  [[self sizeCache] removeAllObjects];
  [self at_reloadData];
}
@end
