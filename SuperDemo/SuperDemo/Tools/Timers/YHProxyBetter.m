//
//  YHProxyBetter.m
//  SuperDemo
//
//  Created by yanghe on 2020/7/26.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import "YHProxyBetter.h"

@implementation YHProxyBetter
+ (instancetype)proxyWithTarget:(id)target
{
    // NSProxy对象不需要调用init，因为它本来就没有init方法
    YHProxyBetter *proxy = [YHProxyBetter alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.target];
}
@end
