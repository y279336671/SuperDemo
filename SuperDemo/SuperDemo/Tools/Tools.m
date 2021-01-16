//
// Created by admin on 2021/1/6.
// Copyright (c) 2021 yanghe. All rights reserved.
//

#import "Tools.h"


@implementation Tools
-(void)printMethodListForIns:(Class)class{
    NSMutableArray *names = [[NSMutableArray alloc] init];
    unsigned int outCount;
    Method *methodList = class_copyMethodList(class, &outCount);
    for (int i = 0; i < outCount; ++i) {
        Method method =  methodList[i];
        NSString *methodName = NSStringFromSelector(method_getName(method));
        [names addObject:methodName];
    }
    free(methodList);
    NSLog(@"names = %@", names);
}

-(void)printIvars:(Class)class {
        unsigned int count;
        Ivar *ivars = class_copyIvarList(class, &count);
        for (int i = 0; i < count; i++) {
            // 取出i位置的成员变量
            Ivar ivar = ivars[i];
            NSLog(@"%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
        }
        free(ivars);
}
@end