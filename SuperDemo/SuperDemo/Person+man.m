//
// Created by yanghe on 2020/7/4.
// Copyright (c) 2020 yanghe. All rights reserved.
//

#import "Person+man.h"
#import <objc/runtime.h>

static NSString *sexKey = @"sexKey";

@implementation Person (man)
//通过关联对象技术，实现为分类添加属性。
- (void)setSex:(NSString *)sex {
    objc_setAssociatedObject(self, &sexKey, sex, OBJC_ASSOCIATION_COPY);
}

- (NSString *)sex {
    return objc_getAssociatedObject(self, &sexKey);
}

//-(void)setWeakObject:(id)weakObject {
////    void *block =
//}
//-(id)weakObject {
//
//}
@end