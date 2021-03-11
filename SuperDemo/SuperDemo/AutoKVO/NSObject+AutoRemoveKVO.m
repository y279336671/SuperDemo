//
// Created by admin on 2021/3/10.
// Copyright (c) 2021 yanghe. All rights reserved.
//

#import "NSObject+AutoRemoveKVO.h"
#import "objc/runtime.h"
#import <objc/message.h>

static const char KVOArrayKey;

@interface WTKVOItem : NSObject
@property(nonatomic, weak) id obj;
@property(nonatomic, strong) NSString *keyPath;
@end

@implementation WTKVOItem
@end




@implementation NSObject (AutoRemoveKVO)
/** 大致思路
 1. 写一个分类，在load方法里面换掉原来的addObserver方法
 2. addObserver方法里面，初始化一个字典，用来存储被监听的对象和keyPath
 3. 交换dealloc方法，如果被监听对象释放了，那么就会进入我们定义的dealloc中，然后从字典中，找到没有删除的keyPath，进行删除
 4. 同时也要交换removeObserver方法，进行判断，是否已经进行了对应keypath的remove
**/

+ (void)load {
    Method addObserver = class_getInstanceMethod(self, @selector(addObserver:forKeyPath:options:context:));
    Method wt_addObserver = class_getInstanceMethod(self, @selector(wt_addObserver:forKeyPath:options:context:));
    method_exchangeImplementations(addObserver, wt_addObserver);

    Method removeObserver = class_getInstanceMethod(self, @selector(removeObserver:forKeyPath:));
    Method wt_removeObserver = class_getInstanceMethod(self, @selector(wt_removeObserver:forKeyPath:));
    method_exchangeImplementations(removeObserver, wt_removeObserver);
}

+ (void)wt_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    if (observer == nil || keyPath == nil || keyPath.length == 0) return;
    NSMutableDictionary *keyPathdict = objc_getAssociatedObject(observer, &KVOArrayKey);
    if (keyPathdict == nil) {
        keyPathdict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(observer, &KVOArrayKey, keyPathdict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    WTKVOItem *item = [WTKVOItem new];
    item.keyPath = keyPath;
    item.obj = self;
    keyPathdict[keyPath] = item;
    [self wt_addObserver:observer forKeyPath:keyPath options:options context:context];

    [self replaceImpl:observer.class];
}

+ (void)wt_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    NSMutableDictionary *keyPaths = objc_getAssociatedObject(observer, &KVOArrayKey);
    if (keyPaths == nil) return;
    if ([keyPaths objectForKey:keyPath]) {
        [self wt_removeObserver:observer forKeyPath:keyPath];
        [keyPaths removeObjectForKey:keyPath];
    }
}

+ (void)wt_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context {
    NSMutableDictionary *keyPaths = objc_getAssociatedObject(observer, &KVOArrayKey);
    if (keyPaths == nil) return;
    if ([keyPaths objectForKey:keyPath]) {
        [self wt_removeObserver:observer forKeyPath:keyPath context:context];
        [keyPaths removeObjectForKey:keyPath];
    }
}

+ (void)replaceImpl:(Class)cls {
    Method dealloc = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));

    __block IMP deallocIMP = method_setImplementation(dealloc, imp_implementationWithBlock(^(__unsafe_unretained id self) {
        ((void (*)(id, SEL)) objc_msgSend)(self, @selector(cleanupSEL));
        ((void (*)(id, SEL)) deallocIMP)(self, NSSelectorFromString(@"dealloc"));
    }));

}

+(void)cleanupSEL
{
    NSMutableDictionary *keyPaths = objc_getAssociatedObject(self, &KVOArrayKey);
    if (keyPaths == nil) return;
    [keyPaths enumerateKeysAndObjectsUsingBlock:^(NSString *_Nonnull key, WTKVOItem *_Nonnull obj, BOOL *_Nonnull stop) {
        [obj.obj removeObserver:self forKeyPath:obj.keyPath];
    }];
    objc_setAssociatedObject(self, &KVOArrayKey, NULL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end