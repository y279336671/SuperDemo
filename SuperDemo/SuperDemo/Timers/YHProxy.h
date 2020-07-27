//
//  YHProxy.h
//  SuperDemo
//
//  Created by yanghe on 2020/7/26.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//解决NSTimer 和 CADisplayLink 循环引用
@interface YHProxy : NSObject
+ (instancetype)proxyWithTarget:(id)target;
@property (weak, nonatomic)id target;
@end

NS_ASSUME_NONNULL_END
