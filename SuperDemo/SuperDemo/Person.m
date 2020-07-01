//
// Created by yanghe on 2020/7/1.
// Copyright (c) 2020 yanghe. All rights reserved.
//

#import "Person.h"
@interface Person()
{
    NSMutableDictionary *_info;//info对外不可变，对内可变
}

@property(nonatomic,copy,readwrite) NSString *name;

@end

//判断如果name相等就认为person相等
@implementation Person

- (instancetype)initWithName:(NSString *)name{
    if (self = [super init]) {
        self.name = name;
    }

    return self;

}
@end