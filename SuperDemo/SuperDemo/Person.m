//
// Created by yanghe on 2020/7/1.
// Copyright (c) 2020 yanghe. All rights reserved.
//

#import "Person.h"
@interface Person()

@end

@implementation Person


// @synthesize语句只能被用在 @implementation 代码段中
// @synthesize的作用就是让编译器为你自动生成setter与getter方法
// @synthesize还有一个作用，可以指定与属性对应的实例变量，例如@synthesize name = xxx
- (instancetype)initWithName:(NSString *)name{
    if (self = [super init]) {   //这行代码的作用？？？？？？？？？？

    }

    return self;
}

@end