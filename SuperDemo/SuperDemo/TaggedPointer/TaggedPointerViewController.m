//
//  TaggedPointerViewController.m
//  SuperDemo
//
//  Created by yanghe on 2020/7/28.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import "TaggedPointerViewController.h"

@interface TaggedPointerViewController ()
@property(nonatomic, copy) NSString *name;
@end

@implementation TaggedPointerViewController

#if (TARGET_OS_OSX || TARGET_OS_IOSMAC) && __x86_64__     //判断平台
// 64-bit Mac - tag bit is LSB
#   define OBJC_MSB_TAGGED_POINTERS 0     //MACOS 平台
#else
// Everything else - tag bit is MSB
#   define OBJC_MSB_TAGGED_POINTERS 1     //iOS 平台
#endif

#if OBJC_MSB_TAGGED_POINTERS
#   define _OBJC_TAG_MASK (1UL<<63)       //iOS 平台
#else
#   define _OBJC_TAG_MASK 1UL             //MACOS 平台
#endif

//判断是否是 tagged pointer

//static inline bool isTaggedPointer(const void * _Nullable ptr)
//{
//    return ((uintptr_t)ptr & _OBJC_TAG_MASK) == _OBJC_TAG_MASK;
//}

BOOL isTaggedPointer(id pointer){
    return ((uintptr_t)pointer & _OBJC_TAG_MASK) == _OBJC_TAG_MASK;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSNumber *num1 = @1;
    NSNumber *num2 = @2;
    NSNumber *num3 = @3;

    NSLog(@"%@,%@,%@", num1, num2, num3); //1,2,3
    NSLog(@"%p,%p,%p", num1, num2, num3); //0x b000 0000 0000 0012,    0x b000 0000 0000 0022,   0x b000 0000 0000 0032
    //iOS平台看最高有效位是否为1，macos平台看最低有效位是否为1
    //0x b000 0000 0000 0012
    //b = 11 = 0b1011    左侧最高位为1 所以是taggerpointer

    bool isTP =  isTaggedPointer(num1);   //判断是否为isTaggedPointer

    for (int i = 0; i < 100000; ++i) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //会在objc_object::release()方法处报EXC_BAD_ACCESS错误。
            //原因是NSString内的值过大时，使用OC对象的方式管理内存，则会调用属性的setter方法，多线程同时release属性，会报EXC_BAD_ACCESS错误
            self.name = [NSString stringWithFormat:@"abccdefghigl;akdjf;alkdj;la;sdlljfals"];
        });
    }

    for (int i = 0; i < 100000; ++i) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //这个则不会报EXC_BAD_ACCESS错误，因为使用的taggerpointer技术，值直接存在指针中，这个过程就是对属性的赋值，并不会调用setter方法
            self.name = [NSString stringWithFormat:@"abc"];
        });
    }



}

//-(void)setName:(NSString *)name{
//    if(_name!=name){
//        [_name release];
//        _name = [name copy];
//    }
//}

@end
