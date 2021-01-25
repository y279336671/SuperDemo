//
//  YHProxy.m
//  SuperDemo
//
//  Created by yanghe on 2020/7/26.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import "YHProxy.h"
@interface YHProxy ()


@end
@implementation YHProxy

+ (instancetype)proxyWithTarget:(id)target{
    YHProxy *proxy = [[YHProxy alloc] init];
    proxy.target = target;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.target;
}

@end
