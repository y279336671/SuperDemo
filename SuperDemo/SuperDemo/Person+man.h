//
// Created by yanghe on 2020/7/4.
// Copyright (c) 2020 yanghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Person (man)

@property(nonatomic, copy) NSString *nickName;
@property (nonatomic, weak) id weakObject;
@property (nonatomic, copy) id copyObject;
@end