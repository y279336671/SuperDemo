//
// Created by admin on 2021/3/16.
// Copyright (c) 2021 yanghe. All rights reserved.
//

#import "YHThreadSafeMutableArray.h"
@interface YHThreadSafeMutableArray ()
@property(nonatomic, copy) NSMutableArray *arr;
@property(nonatomic, strong) dispatch_queue_t concurrentQueue;
@end

@implementation YHThreadSafeMutableArray
-(instancetype)init{
    self = [super init];
    if (self) {
        NSString *identifier = [NSString stringWithFormat:@"<ZHMutableArray>%p",self];
        self.concurrentQueue = dispatch_queue_create([identifier UTF8String], DISPATCH_QUEUE_CONCURRENT);
        self.arr = [NSMutableArray array];
    }
    return self;
}

- (NSMutableArray *)array
{
    __block NSMutableArray *safeArray;
    dispatch_sync(_concurrentQueue, ^{
        safeArray = self.arr;
    });
    return safeArray;
}

- (BOOL)containsObject:(id)anObject
{
    __block BOOL isExist = NO;
    dispatch_sync(_concurrentQueue, ^{
        isExist = [self.arr containsObject:anObject];
    });
    return isExist;
}

- (NSUInteger)count
{
    __block NSUInteger count;
    dispatch_sync(_concurrentQueue, ^{
        count = self.arr.count;
    });
    return count;
}

- (id)objectAtIndex:(NSUInteger)index
{
    __block id obj;
    dispatch_sync(_concurrentQueue, ^{
        if (index < [self.arr count]) {
            obj = self.arr[index];
        }
    });
    return obj;
}

- (NSEnumerator *)objectEnumerator
{
    __block NSEnumerator *enu;
    dispatch_sync(_concurrentQueue, ^{
        enu = [self.arr objectEnumerator];
    });
    return enu;
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index
{
    dispatch_barrier_async(_concurrentQueue, ^{
        if (anObject && index < [self.arr count]) {
            [self.arr insertObject:anObject atIndex:index];
        }
    });
}

- (void)addObject:(id)anObject
{
    dispatch_barrier_async(_concurrentQueue, ^{
        if(anObject){
            [self.arr addObject:anObject];
        }
    });
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    dispatch_barrier_async(_concurrentQueue, ^{

        if (index < [self.arr count]) {
            [self.arr removeObjectAtIndex:index];
        }
    });
}

- (void)removeObject:(id)anObject
{
    dispatch_barrier_async(_concurrentQueue, ^{
        [self.arr removeObject:anObject];//外边自己判断合法性
    });
}

- (void)removeLastObject
{
    dispatch_barrier_async(_concurrentQueue, ^{
        [self.arr removeLastObject];
    });
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    dispatch_barrier_async(_concurrentQueue, ^{
        if (anObject && index < [self.arr count]) {
            [self.arr replaceObjectAtIndex:index withObject:anObject];
        }
    });
}

- (NSUInteger)indexOfObject:(id)anObject
{
    __block NSUInteger index = NSNotFound;
    dispatch_sync(_concurrentQueue, ^{
        for (int i = 0; i < [self.arr count]; i ++) {
            if (self.arr[i] == anObject) {
                index = i;
                break;
            }
        }
    });
    return index;
}

- (void)dealloc
{
    if (_concurrentQueue) {
        _concurrentQueue = NULL;
    }
}

@end