//
// Created by admin on 2021/1/18.
// Copyright (c) 2021 yanghe. All rights reserved.
//

#import <NSArray+YYAdd.h>
#import "YHSafeMutableArray.h"
#define INIT(...) self = super.init; \
if (!self) return nil;               \
 _concurrentQueue = dispatch_queue_create([[NSString stringWithFormat:@"%p", self] UTF8String], DISPATCH_QUEUE_CONCURRENT); \
 __VA_ARGS__; \
if (!_arr) return nil; \
return self;


@interface YHSafeMutableArray()

@property (nonatomic,strong)dispatch_queue_t concurrentQueue;
@property (nonatomic,strong)NSMutableArray *arr;

@end

@implementation YHSafeMutableArray

#pragma mark - init

- (instancetype)init {
    INIT(_arr = [[NSMutableArray alloc] init];)
}

- (instancetype)initWithCapacity:(NSUInteger)numItems {
    INIT(_arr =[[NSMutableArray alloc] initWithCapacity:numItems])
}

- (instancetype)initWithArray:(NSArray *)array {
    INIT(_arr =[[NSMutableArray alloc] initWithArray:array])
}

- (instancetype)initWithObjects:(const id[])objects count:(NSUInteger)cnt {
    INIT(_arr =[[NSMutableArray alloc] initWithObjects:objects count:cnt])
}

- (instancetype)initWithContentsOfFile:(NSString *)path {
    INIT(_arr =[[NSMutableArray alloc] initWithContentsOfFile:path])
}

- (instancetype)initWithContentsOfURL:(NSURL *)url {
    INIT(_arr =[[NSMutableArray alloc] initWithContentsOfURL:url])
}

//#pragma mark - method
//
- (NSUInteger)count {
    __block NSUInteger count;
    dispatch_sync(_concurrentQueue, ^{
        count = self.arr.count;
    });
    return count;
}

- (id)objectAtIndex:(NSUInteger)index {
    __block id obj;
    dispatch_sync(_concurrentQueue, ^{
        if (index < [_arr count]) {
            obj = [_arr objectAtIndex:index];
        }
    });
    return obj;
}
- (BOOL)containsObject:(id)anObject {
    __block BOOL isExist = NO;
    dispatch_sync(_concurrentQueue, ^{
        isExist = [_arr containsObject:anObject];
    });
    return isExist;
}

//- (NSUInteger)indexOfObject:(id)anObject {
//    __block NSUInteger index = NSNotFound;
//    dispatch_sync(_concurrentQueue, ^{
//        for (int i = 0; i < [self.arr count]; i ++) {
//            if ([_arr objectAtIndex:i] == anObject) {
//                index = i;
//                break;
//            }
//        }
//    });
//    return index;
//}
- (id)firstObject {
    __block id first ;
    dispatch_sync(_concurrentQueue, ^{
        first = _arr.firstObject;
    });
    return first;
}
//
- (id)lastObject {
    __block id last ;
    dispatch_sync(_concurrentQueue, ^{
        last = _arr.lastObject;
    });
    return last;
}
//- (NSArray *)arrayByAddingObject:(id)anObject {
//    LOCK(NSArray * arr = [_arr arrayByAddingObject:anObject]); return arr;
//}
//
//- (NSArray *)arrayByAddingObjectsFromArray:(NSArray *)otherArray {
//    LOCK(NSArray * arr = [_arr arrayByAddingObjectsFromArray:otherArray]); return arr;
//}
//
//- (NSString *)componentsJoinedByString:(NSString *)separator {
//    LOCK(NSString * str = [_arr componentsJoinedByString:separator]); return str;
//}
//

//
//- (NSString *)description {
//    LOCK(NSString * d = _arr.description); return d;
//}
//
//- (NSString *)descriptionWithLocale:(id)locale {
//    LOCK(NSString * d = [_arr descriptionWithLocale:locale]); return d;
//}
//
//- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
//    LOCK(NSString * d = [_arr descriptionWithLocale:locale indent:level]); return d;
//}
//
//- (id)firstObjectCommonWithArray:(NSArray *)otherArray {
//    LOCK(id o = [_arr firstObjectCommonWithArray:otherArray]); return o;
//}
//
//- (void)getObjects:(id __unsafe_unretained[])objects range:(NSRange)range {
//    LOCK([_arr getObjects:objects range:range]);
//}
//

//
//- (NSUInteger)indexOfObject:(id)anObject inRange:(NSRange)range {
//    LOCK(NSUInteger i = [_arr indexOfObject:anObject inRange:range]); return i;
//}
//
//- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject {
//    LOCK(NSUInteger i = [_arr indexOfObjectIdenticalTo:anObject]); return i;
//}
//
//- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
//    LOCK(NSUInteger i = [_arr indexOfObjectIdenticalTo:anObject inRange:range]); return i;
//}
//
//
//- (NSEnumerator *)objectEnumerator {
//    LOCK(NSEnumerator * e = [_arr objectEnumerator]); return e;
//}
//
//- (NSEnumerator *)reverseObjectEnumerator {
//    LOCK(NSEnumerator * e = [_arr reverseObjectEnumerator]); return e;
//}
//
//- (NSData *)sortedArrayHint {
//    LOCK(NSData * d = [_arr sortedArrayHint]); return d;
//}
//
//- (NSArray *)sortedArrayUsingFunction:(NSInteger (*)(id, id, void *))comparator context:(void *)context {
//    LOCK(NSArray * arr = [_arr sortedArrayUsingFunction:comparator context:context]) return arr;
//}
//
//- (NSArray *)sortedArrayUsingFunction:(NSInteger (*)(id, id, void *))comparator context:(void *)context hint:(NSData *)hint {
//    LOCK(NSArray * arr = [_arr sortedArrayUsingFunction:comparator context:context hint:hint]); return arr;
//}
//
//- (NSArray *)sortedArrayUsingSelector:(SEL)comparator {
//    LOCK(NSArray * arr = [_arr sortedArrayUsingSelector:comparator]); return arr;
//}
//
//- (NSArray *)subarrayWithRange:(NSRange)range {
//    LOCK(NSArray * arr = [_arr subarrayWithRange:range]) return arr;
//}
//
//- (void)makeObjectsPerformSelector:(SEL)aSelector {
//    LOCK([_arr makeObjectsPerformSelector:aSelector]);
//}
//
//- (void)makeObjectsPerformSelector:(SEL)aSelector withObject:(id)argument {
//    LOCK([_arr makeObjectsPerformSelector:aSelector withObject:argument]);
//}
//
//- (NSArray *)objectsAtIndexes:(NSIndexSet *)indexes {
//    LOCK(NSArray * arr = [_arr objectsAtIndexes:indexes]); return arr;
//}
//
//- (id)objectAtIndexedSubscript:(NSUInteger)idx {
//    LOCK(id o = [_arr objectAtIndexedSubscript:idx]); return o;
//}
//
//- (void)enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block {
//    LOCK([_arr enumerateObjectsUsingBlock:block]);
//}
//
//- (void)enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block {
//    LOCK([_arr enumerateObjectsWithOptions:opts usingBlock:block]);
//}
//
//- (void)enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block {
//    LOCK([_arr enumerateObjectsAtIndexes:s options:opts usingBlock:block]);
//}
//
//- (NSUInteger)indexOfObjectPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate {
//    LOCK(NSUInteger i = [_arr indexOfObjectPassingTest:predicate]); return i;
//}
//
//- (NSUInteger)indexOfObjectWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate {
//    LOCK(NSUInteger i = [_arr indexOfObjectWithOptions:opts passingTest:predicate]); return i;
//}
//
//- (NSUInteger)indexOfObjectAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate {
//    LOCK(NSUInteger i = [_arr indexOfObjectAtIndexes:s options:opts passingTest:predicate]); return i;
//}
//
//- (NSIndexSet *)indexesOfObjectsPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate {
//    LOCK(NSIndexSet * i = [_arr indexesOfObjectsPassingTest:predicate]); return i;
//}
//
//- (NSIndexSet *)indexesOfObjectsWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate {
//    LOCK(NSIndexSet * i = [_arr indexesOfObjectsWithOptions:opts passingTest:predicate]); return i;
//}
//
//- (NSIndexSet *)indexesOfObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate {
//    LOCK(NSIndexSet * i = [_arr indexesOfObjectsAtIndexes:s options:opts passingTest:predicate]); return i;
//}
//
//- (NSArray *)sortedArrayUsingComparator:(NSComparator)cmptr {
//    LOCK(NSArray * a = [_arr sortedArrayUsingComparator:cmptr]); return a;
//}
//
//- (NSArray *)sortedArrayWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr {
//    LOCK(NSArray * a = [_arr sortedArrayWithOptions:opts usingComparator:cmptr]); return a;
//}
//
//- (NSUInteger)indexOfObject:(id)obj inSortedRange:(NSRange)r options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator)cmp {
//    LOCK(NSUInteger i = [_arr indexOfObject:obj inSortedRange:r options:opts usingComparator:cmp]); return i;
//}

#pragma mark - mutable

- (void)addObject:(id)anObject {
    dispatch_barrier_async(_concurrentQueue, ^{
        if(anObject){
            [_arr addObject:anObject];
        }
    });
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    dispatch_barrier_async(_concurrentQueue, ^{
        if(anObject&&index<[_arr count]){
            [_arr insertObject:anObject atIndex:index];
        }
    });
}

- (void)removeLastObject {
    dispatch_barrier_async(_concurrentQueue, ^{
        if([_arr count] >0){
            [_arr removeLastObject];

        }
    });
}

- (void)removeFirstObject {
    dispatch_barrier_async(_concurrentQueue, ^{
        if([_arr count] >0){
            [_arr removeFirstObject];
        }
    });
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    dispatch_barrier_async(_concurrentQueue, ^{
        if(index<[_arr count]){
            [_arr removeObjectAtIndex:index];
        }
    });
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {

    dispatch_barrier_async(_concurrentQueue, ^{
        if (index < [_arr count] && anObject) {
            [_arr replaceObjectAtIndex:index withObject:anObject];
        }
    });
}

- (void)addObjectsFromArray:(NSArray *)otherArray {
    dispatch_barrier_async(_concurrentQueue, ^{
        if(otherArray){
            [_arr addObjectsFromArray:otherArray];
        }
    });
}

- (void)setArray:(NSArray *)otherArray {
    dispatch_barrier_async(_concurrentQueue, ^{
        if(otherArray){
            [_arr setArray:otherArray];
        }
    });
}

- (void)removeObject:(id)anObject {
    dispatch_barrier_async(_concurrentQueue, ^{
        if(anObject){
            [_arr removeObject:anObject];
        }
    });
}

- (void)removeAllObjects {
    dispatch_barrier_async(_concurrentQueue, ^{
        [_arr removeAllObjects];
    });
}

//- (void)removeObject:(id)anObject inRange:(NSRange)range {
//    LOCK([_arr removeObject:anObject inRange:range]);
//}
//- (void)removeObjectsInArray:(NSArray *)otherArray {
//    LOCK([_arr removeObjectsInArray:otherArray]);
//}
//- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
//    LOCK([_arr exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2]);
//}
//
//- (void)removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
//    LOCK([_arr removeObjectIdenticalTo:anObject inRange:range]);
//}
//
//- (void)removeObjectIdenticalTo:(id)anObject {
//    LOCK([_arr removeObjectIdenticalTo:anObject]);
//}
//
//- (void)removeObjectsInRange:(NSRange)range {
//    LOCK([_arr removeObjectsInRange:range]);
//}
//
//- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange {
//    LOCK([_arr replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange]);
//}
//
//- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray {
//    LOCK([_arr replaceObjectsInRange:range withObjectsFromArray:otherArray]);
//}
//
//- (void)sortUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context {
//    LOCK([_arr sortUsingFunction:compare context:context]);
//}
//
//- (void)sortUsingSelector:(SEL)comparator {
//    LOCK([_arr sortUsingSelector:comparator]);
//}
//
//- (void)insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
//    LOCK([_arr insertObjects:objects atIndexes:indexes]);
//}
//
//- (void)removeObjectsAtIndexes:(NSIndexSet *)indexes {
//    LOCK([_arr removeObjectsAtIndexes:indexes]);
//}
//
//- (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects {
//    LOCK([_arr replaceObjectsAtIndexes:indexes withObjects:objects]);
//}
//
//- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
//    LOCK([_arr setObject:obj atIndexedSubscript:idx]);
//}
//
//- (void)sortUsingComparator:(NSComparator)cmptr {
//    LOCK([_arr sortUsingComparator:cmptr]);
//}
//
//- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr {
//    LOCK([_arr sortWithOptions:opts usingComparator:cmptr]);
//}
//
//- (BOOL)isEqualToArray:(NSArray *)otherArray {
//    if (otherArray == self) return YES;
//    if ([otherArray isKindOfClass:YYThreadSafeArray.class]) {
//        YYThreadSafeArray *other = (id)otherArray;
//        BOOL isEqual;
//        isEqual = [_arr isEqualToArray:other->_arr];
//        return isEqual;
//    }
//    return NO;
//}
//
//#pragma mark - protocol
//
//- (id)copyWithZone:(NSZone *)zone {
//    return [self mutableCopyWithZone:zone];
//}
//
//- (id)mutableCopyWithZone:(NSZone *)zone {
//    LOCK(id copiedDictionary = [[self.class allocWithZone:zone] initWithArray:_arr]);
//    return copiedDictionary;
//}
//
//- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
//                                  objects:(id __unsafe_unretained[])stackbuf
//                                    count:(NSUInteger)len {
//    LOCK(NSUInteger count = [_arr countByEnumeratingWithState:state objects:stackbuf count:len]);
//    return count;
//}
//
//- (BOOL)isEqual:(id)object {
//    if (object == self) return YES;
//
//    if ([object isKindOfClass:YYThreadSafeArray.class]) {
//        YYThreadSafeArray *other = object;
//        BOOL isEqual;
//        isEqual = [_arr isEqual:other->_arr];
//        return isEqual;
//    }
//    return NO;
//}
//
//- (NSUInteger)hash {
//    LOCK(NSUInteger hash = [_arr hash]);
//    return hash;
//}
@end
