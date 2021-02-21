//
// Created by admin on 2021/1/6.
// Copyright (c) 2021 yanghe. All rights reserved.
//

#import "Tools.h"
#import "../Inherit/Person.h"


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

// 1. 手动调用load 。   可用单例模式解决
// 2. 子类没有实现父类的方法
// 3. 子类和父类都没有实现
// 4. 类方法

+ (void)zb_betterMethodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swizzledSEL:(SEL)swizzledSEL{

    if (!cls) NSLog(@"传入的交换类不能为空");

    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    Method swiMethod = class_getInstanceMethod(cls, swizzledSEL);
//    // 一般交换方法: 交换自己有的方法 -- 走下面 因为自己有意味添加方法失败
//    // 交换自己没有实现的方法:
//    //   首先第一步:会先尝试给自己添加要交换的方法 :personInstanceMethod (SEL) -> swiMethod(IMP)
//    //   然后再将父类的IMP给swizzle  personInstanceMethod(imp) -> swizzledSEL
//    //oriSEL:personInstanceMethod
//    BOOL didAddMethod = class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
//    if (didAddMethod) {
//        class_replaceMethod(cls, swizzledSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
//    }else{
        method_exchangeImplementations(oriMethod, swiMethod);  // method_exchangeImplementations 交换的是 class_rw_t -> method_list_t -> method_t  -> IMP   ,并且调用这个方法就会清空 caches_t
//    }
}

@end