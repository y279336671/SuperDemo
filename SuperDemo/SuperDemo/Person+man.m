//
// Created by yanghe on 2020/7/4.
// Copyright (c) 2020 yanghe. All rights reserved.
//

#import "Person+man.h"
#import <objc/runtime.h>

@implementation Person (man)
//通过关联对象技术，实现为分类添加属性。
- (void)setNickName:(NSString *)nickName {
    objc_setAssociatedObject(self, @selector(nickName), nickName, OBJC_ASSOCIATION_COPY);
}

- (NSString *)nickName {
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setWeakObject:(id)weakObject {
    id __weak temp = weakObject;
    id (^TempBlock)(void)=^{
        return temp;
    };
    objc_setAssociatedObject(self, @selector(weakObject), TempBlock, OBJC_ASSOCIATION_COPY);
}

-(id)weakObject {
    id (^TempBlock)(void) =  objc_getAssociatedObject(self, _cmd);
    return TempBlock?TempBlock():nil;
}

- (void)setCopyObject:(id)copyObject {
    objc_setAssociatedObject(self, @selector(copyObject), copyObject, OBJC_ASSOCIATION_COPY);
}

- (id)copyObject {
    return   objc_getAssociatedObject(self, _cmd);
}



@end