//
//  NSMutableDictionary+ATKit.h
//  Postre
//
//  Created by 王炜圣 on 2017/4/6.
//  Copyright © 2017年 王炜圣. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  添加字典时数据安全
 */
#ifndef SafeDicObj
#define SafeDicObj(obj) ((obj) ? (obj) : @"")
#endif

@interface NSMutableDictionary (ATKit)
- (void)setParam:(id)object forKey:(NSString *)key;
@end

@interface NSArray<ObjectType> (ATKit)
- (ObjectType)objectSafeAtIndex:(NSUInteger)index;
- (ObjectType)secondObject;
@end

@interface NSMutableArray<ObjectType> (ATKit)
- (void)addSafeObject:(id)anObject;

/**
 添加数组元素 过滤器
 */
- (void)addObjects:(NSArray<ObjectType> *)objects minFilter:(BOOL(^)(ObjectType existObj, ObjectType addObj))filter;
- (void)addObjects:(NSArray<ObjectType> *)objects filter:(BOOL(^)(ObjectType existObj, ObjectType addObj))filter;
- (void)addObjects:(NSArray<ObjectType> *)objects checkCount:(NSInteger)checkCount filter:(BOOL(^)(ObjectType existObj, ObjectType addObj))filter;
@end
