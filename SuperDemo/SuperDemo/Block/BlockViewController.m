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

@interface BlockViewController ()
{
    NSString *_name;
}
@end

@implementation BlockViewController

int a=1;
- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%@",[^{
        NSLog(@"11111");  //只要不捕获局部变量，就是全局__NSGlobalBlock__
    } class]);

    NSLog(@"%@",[^{
        NSLog(@"11111%d",a);  //只要不捕获局部变量，就是全局__NSGlobalBlock__
    } class]);

    int age = 10;
    void (^block)(void) = ^{
        NSLog(@"-------%d",age);
    };
    NSLog(@"block = %@", [block class]); // 由于复制给了void (^block)(void)，所以arc下会自动copy到堆上，mrc下还是栈上

    void (^block1)(void) = ^{
        NSLog(@"-------");
    };
    NSLog(@"block = %@", [block1 class]);

    NSLog(@"%@", [^{
        NSLog(@"---------%d",age);
    } class]);   // 没有复制给任何对象，所以所以是栈上

    [self testWithBlock:^{

        NSLog(@"%@",self);
    }];
}


- (void)testWithBlock:(dispatch_block_t)block
{
    block();

    dispatch_block_t tempBlock = block;

    NSLog(@"%@,%@",[block class],[tempBlock class]); // block 当参数是在栈上，tempBlock是在arc下是在堆上
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
