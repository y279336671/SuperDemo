//
//  BlockViewController.m
//  SuperDemo
//
//  Created by admin on 2021/2/13.
//  Copyright © 2021 yanghe. All rights reserved.
//

#import "BlockViewController.h"
#import "Person.h"
#import "ViewController.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>


typedef void (^TestBlock)(void);
//typedef void(^TRPopupCompletionBlock)(TRPopupView *popupView, BOOL finished);
@interface BlockViewController ()
{
    NSString *_name;
}
@property(nonatomic, copy) TestBlock block;
@property(nonatomic, strong) NSString *title;
@end

@implementation BlockViewController

int a=1;
- (void)viewDidLoad {
    [super viewDidLoad];
    Person *person = [[Person alloc] init];
//    size_t szie = class_getInstanceSize([NSObject class]);
//
//    size_t szie1 = malloc_size((__bridge const void *)NSObject);
//
//    NSLog(@"szie = %lu", szie);
//    NSLog(@"szie1 = %lu", szie1);
//    self.title = @"测试NSOperationQueue mainQueue 是否能释放";
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        NSLog(@"self.na = %@", self.title);
//    }];
//---------------------不会产生强引用-----------------------
//    _name=  @"yanghe";
//    NSString *tempName= _name;
//    self.block = ^{ // 这个位置如果是局部变量的block也不会产生强引用,由于arc下block被复制到堆上，避免被释放掉
//        NSLog(@"_name = %@", _name);// 会产生强引用，因为_name 相当于self->_name
//        NSLog(@"_name = %@", tempName);// 不会产生强引用，因为并没有截获self，tempName的内存地址和_name是同一个
//    };
//    self.block();
//-----------------------------------------------------------

//---------------------------各种block类型判断--------------------------------
//    1. 看是否截获变量
//    2. 看是否复制给对象
    NSLog(@"block1==%@",[^{
        NSLog(@"11111");  //只要不捕获局部变量，就是全局__NSGlobalBlock__
    } class]);

    NSLog(@"block2==%@",[^{
        NSLog(@"11111%d",a);  //只要不捕获局部变量，就是全局__NSGlobalBlock__
    } class]);

    int age = 10;
    void (^block)(void) = ^{
        NSLog(@"-------%d",age);
    };
    NSLog(@"block3 = %@", [block class]); // __NSMallocBlock__ 由于复制给了void (^block)(void)，所以arc下会自动copy到堆上，mrc下还是栈上

    void (^block1)(void) = ^{
        NSLog(@"-------");
    };
    NSLog(@"block4 = %@", [block1 class]); // __NSGlobalBlock__

    NSLog(@"block5==%@", [^{
        NSLog(@"---------%d",age);
    } class]);   // 没有复制给任何对象，所以所以是栈上   .__NSStackBlock__

    [self testWithBlock:^{
        NSLog(@"%@",self);
    }];

    //---------------------------各种block类型判断--------------------------------
}


- (void)testWithBlock:(dispatch_block_t)block
{
    block();

    dispatch_block_t tempBlock = block;

    NSLog(@"block6 ==%@,%@",[block class],[tempBlock class]); // __NSStackBlock__,__NSMallocBlock__ block 当参数是在栈上，tempBlock是在arc下是在堆上
}

- (void)dealloc {
    NSLog(@"%@   dealloc", NSStringFromClass([self class]));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
