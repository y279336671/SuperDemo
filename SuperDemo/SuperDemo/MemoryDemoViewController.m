//
//  MemoryDemoViewController.m
//  SuperDemo
//
//  Created by yanghe on 2020/7/26.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import "MemoryDemoViewController.h"
#import "MJTimer.h"


@implementation HTPerson
//- (void)sayHello { NSLog(@"%s: 你好", __func__); }
- (void)sayHello { NSLog(@"%s: 你好,%@", __func__, self.name); }
@end


@interface MemoryDemoViewController ()
@property (strong, nonatomic) CADisplayLink *link;
@property (strong, nonatomic) NSTimer *timer;
@property (copy, nonatomic) NSString *task;
@end

@implementation MemoryDemoViewController

- (void)viewDidLoad {
    // self  _cmd
    [super viewDidLoad]; // ->  __rw_objc_super -> {self,ViewController}
    // --------------------------------------------内存平移--------------------------------------------
    // 关键点:  实例对象和类对象都是通过isa指针到类对象中查找方法。
    // 1. 类对象调用实例方法
    // 指针读取类地址，强转为对象，调用sayHello。
    Class cls = [HTPerson class]; //类对象的地址，就是isa指针的地址
    void * ht = &cls;
    [(__bridge id)ht sayHello];
//    类结构->  isa  superclass  cache_t class_data_bits_t-> class_rw_t->class_ro_t
//    对象结构-> isa   和 属性值

    // 实例化对象，调用sayHello
    HTPerson * person = [HTPerson new];
    person.name=@"yh";
    [person sayHello];
    // 为什么会调用成功？
    // 因为实例对象中只有isa指针和属性值，方法都存在类对象中。第一种是直接找到isa指针，然后去类对象中调用对应的方法，和实例对象调用的原理是一样的。

    // 为什么打印了<MemoryDemoViewController: 0x7f8f0ac13e20>
    // 局部变量是存储在栈中，栈是高地址向低地址增长的连续内存，所以这个方法的入栈顺序是 self->cmd->__rw_objc_super->cls->ht
    // 常规是从高地址到低地址入栈，只有结构体内部是低地址到高地址入栈，所以 self->cmd->ViewController->self->cls->ht
    // 栈内地址是连续的，所以我们可以通过地址平移的方式，来读取前后元素,读取的就是<MemoryDemoViewController: 0x7f8f0ac13e20>
    // --------------------------------------------内存平移--------------------------------------------



//    // 保证调用频率和屏幕的刷帧频率一致，60FPS
//    self.link = [CADisplayLink displayLinkWithTarget:[YHProxy proxyWithTarget:self] selector:@selector(linkTest)];
//    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[YHProxy proxyWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];
//
//    __weak typeof(self) weakSelf = self;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [weakSelf timerTest];
//    }];

    // 接口设计
//    self.task = [MJTimer execTask:self
//                         selector:@selector(doTask)
//                            start:2.0
//                         interval:1.0
//                          repeats:YES
//                            async:NO];
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", sel_getName(_cmd));
}

- (void)timerTest
{
    NSLog(@"%s", __func__);
}

- (void)linkTest
{
    NSLog(@"%s", __func__);
}

- (void)doTask{
    NSLog(@"GCD Timer");
}
@end

