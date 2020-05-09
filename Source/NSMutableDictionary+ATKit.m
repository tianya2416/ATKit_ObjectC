//
//  NSMutableDictionary+ATKit.m
//  Postre
//
//  Created by 王炜圣 on 2017/4/6.
//  Copyright © 2017年 王炜圣. All rights reserved.
//

#import "NSMutableDictionary+ATKit.h"

@implementation NSMutableDictionary (ATKit)
- (void)setParam:(id)object forKey:(NSString *)key {
    if (object && key.length) {
        [self setObject:object forKey:key];
    }
}
@end

@implementation NSArray (ATKit)

- (id)objectSafeAtIndex:(NSUInteger)index {
    return index < self.count ? [self objectAtIndex:index] : nil;
}
- (id)secondObject {
    return [self objectSafeAtIndex:1];
}
@end

@implementation NSMutableArray (ATKit)

- (void)addSafeObject:(id)anObject {
    if (anObject) {
        [self addObject:anObject];
    }
}
- (void)addObjects:(NSArray *)objects filter:(BOOL (^)(id, id))filter {
    [self addObjects:objects checkCount:self.count filter:filter];
}
- (void)addObjects:(NSArray *)objects minFilter:(BOOL (^)(id, id))filter {
    [self addObjects:objects checkCount:objects.count filter:filter];
}
- (void)addObjects:(NSArray *)objects checkCount:(NSInteger)checkCount filter:(BOOL (^)(id, id))filter {
    if (checkCount > self.count) {
        checkCount = self.count;
    }
    for (id item in objects) {
        BOOL duplicate = NO;
        for (int i = 0; i < checkCount; i++) {
            id exsitItem = self[self.count - 1 - i];
            duplicate = filter(exsitItem, item);
            if (duplicate) {
                break;
            }
        }
        if (!duplicate) {
            [self addObject:item];
        }
    }
}
@end
