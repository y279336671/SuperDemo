//
// Created by yanghe on 2021/2/18.
// Copyright (c) 2021 yanghe. All rights reserved.
//

#import "MessagesForwarding.h"
#import <objc/runtime.h>


@implementation MessagesForwarding
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(testforwarding)) {
        // 获取其他方法
        Method method = class_getInstanceMethod(self, @selector(sel));

        // 动态添加test方法的实现
        class_addMethod(self, sel,
                        method_getImplementation(method),
                        method_getTypeEncoding(method));

        // 返回YES代表有动态添加方法
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if([NSStringFromSelector(aSelector) isEqualToString:@"testforwarding"]){
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {

     SEL sef =  anInvocation.selector;

    [super forwardInvocation:anInvocation];
}


@end