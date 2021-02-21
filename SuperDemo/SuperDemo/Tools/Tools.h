//
// Created by admin on 2021/1/6.
// Copyright (c) 2021 yanghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface Tools : NSObject
-(void)printMethodListForIns:(Class)class;
+ (void)zb_betterMethodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swizzledSEL:(SEL)swizzledSEL;
@end