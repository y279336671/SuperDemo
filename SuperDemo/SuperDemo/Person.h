//
// Created by yanghe on 2020/7/1.
// Copyright (c) 2020 yanghe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject
//@property (nonatomic, assign)NSString *name;   //为什么assign修饰对象不会报错？
@property(nonatomic, copy, readonly) NSString *name;       //NSString为什么使用copy,copy和strong区别
@property(nonatomic, assign) NSInteger age;    //weak 和 assign的区别

@property(nonatomic,strong) NSDictionary *info;//info对外不可变，对内可变
- (instancetype)initWithName:(NSString *)name;

@end