//
//  ViewController.m
//  SuperDemo
//
//  Created by yanghe on 2020/6/21.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import <objc/runtime.h>
#import "ViewController.h"
#import "Person.h"
#import "Person+man.h"
#import "MemoryDemoViewController.h"
#import "TaggedPointer/TaggedPointerViewController.h"
@interface ViewController ()

//@property(nonatomic, copy) int (^testBlcok)(int n);
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"测试函数地址1");
    NSLog(@"测试函数地址2");

//    int double_num_times_asm(int num, int times);
    // 1. 0x00000001002d0000
    // 2. 0x00000001028bc000        0x1028c4200      00008020
    //0x00000001005e0000+0x8020
//    [self.view setBackgroundColor:UIColor.redColor];
//    [self taggedpointerDemo];
//    [self exeBlock];
}



-(void)exeBlock{
    void (^block)(void)=^{
        NSLog(@"------%p",self,_cmd);// 方法默认会传递self _cmd参数，参数属于局部变量，所以会捕获
        NSLog(@"------%p",_str);   // 也会捕获，_str 相当于self->_str  ,self是局部两变量，所以也会捕获_str
        NSLog(@"------%p",[self str]);//转成 objc_msgSend(self,@selector(str))   ,同理还是会捕获self
    };
}

//测试tagged pointer
-(void)taggedpointerDemo{
    UIButton *test = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [test addTarget:self action:@selector(testEvent) forControlEvents:UIControlEventTouchUpInside];
    [test setTitle:@"testbutton" forState:UIControlStateNormal];
    [self.view addSubview:test];
}
-(void)testEvent{
    TaggedPointerViewController *tg = [[TaggedPointerViewController alloc] init];

    [tg.view setBackgroundColor:UIColor.yellowColor];
    [self.navigationController pushViewController:tg animated:YES];
}

//测试timer
-(void)memoryDemo{
    UIButton *memoryDemo = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [memoryDemo addTarget:self action:@selector(showMemoryDemo) forControlEvents:UIControlEventTouchUpInside];
    [memoryDemo setTitle:@"memory" forState:UIControlStateNormal];
    [self.view addSubview:memoryDemo];
}
-(void)showMemoryDemo{
    MemoryDemoViewController *memoryDemo = [[MemoryDemoViewController alloc] init];
    [memoryDemo.view setBackgroundColor:UIColor.yellowColor];
    [self.navigationController pushViewController:memoryDemo animated:YES];
}
@end
