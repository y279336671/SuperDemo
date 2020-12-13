//
//  MultithreadingViewController.m
//  SuperDemo
//
//  Created by admin on 2020/11/18.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import "MultithreadingViewController.h"

@interface MultithreadingViewController ()

@end

@implementation MultithreadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self interview1];
//    [self interview2];
//    [self interview3];
//    [self interview4];
//    [self interview5];
//    [self interview55];
//    [self interview555];
//    [self interview6];
//    [self interview7];
//    [self interview8];
//    [self interview9];
    [self interview10];
}

- (void)interview1{
    NSLog(@"0---%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"1---%@",[NSThread currentThread]);
        //GNUstep  -> NSFuncation  源码
        [self performSelector:@selector(test1) withObject:nil afterDelay:.0f];//添加一个timer到runloop，但是没有启动执行
        NSLog(@"3---%@",[NSThread currentThread]);
        //[NSRunLoop currentRunLoop] 获取当前线程的runloop，注意是当前线程，如果当前线程没有runloop就创建
//        // 添加以下两行才能执行
//        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
//        // 只添加这一行也可以，因为performSelector底层已经被加入runloop，只是没有启动
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

//        同理NSTimer 也不能执行
    });

//    以下代码输出是 132，在主线程中默认有runloop。 runloop何时去处理timer事件？？？？？？？？？？？、
//    NSLog(@"1---%@",[NSThread currentThread]);
//    [self performSelector:@selector(test1) withObject:nil afterDelay:.0f];//默认GCD不会启动runloop，afterDelay需要runloop支持
//    NSLog(@"3---%@",[NSThread currentThread]);
}
- (void)test1{
    NSLog(@"2---%@",[NSThread currentThread]);
}

- (void)interview2{
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1---%@",[NSThread currentThread]);
        //        // 添加以下两行才能执行
//        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        // 只添加这一行也可以，因为performSelector底层已经被加入runloop，只是没有启动
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }];
    [thread start];
    [self performSelector:@selector(test2) onThread:thread withObject:nil waitUntilDone:YES];
}
- (void)test2{
    NSLog(@"2---%@",[NSThread currentThread]);
}

- (void)interview3{
    NSLog(@"执行任务1--%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{   //dispatch_async 不会死锁，虽然在主队列执行，但是不要求立即执行
        NSLog(@"执行任务2--%@",[NSThread currentThread]);
    });
    NSLog(@"执行任务3--%@",[NSThread currentThread]);
}

- (void)interview4{
    NSLog(@"执行任务1--%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"执行任务2--%@",[NSThread currentThread]);
    });
    NSLog(@"执行任务3--%@",[NSThread currentThread]);
}
- (void)interview5{
    NSLog(@"执行任务1--%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2--%@",[NSThread currentThread]);
        dispatch_sync(queue, ^{
            NSLog(@"执行任务3--%@",[NSThread currentThread]);
        });
        NSLog(@"执行任务4--%@",[NSThread currentThread]);
    });
    NSLog(@"执行任务5--%@",[NSThread currentThread]);
}
- (void)interview55{
    NSLog(@"执行任务1--%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue1 = dispatch_queue_create("myqueu1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2--%@",[NSThread currentThread]);
        dispatch_sync(queue1, ^{
            NSLog(@"执行任务3--%@",[NSThread currentThread]);
        });
        NSLog(@"执行任务4--%@",[NSThread currentThread]);
    });
    NSLog(@"执行任务5--%@",[NSThread currentThread]);
}

- (void)interview6{
    NSLog(@"执行任务1--%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("myqueu2", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2--%@",[NSThread currentThread]);

        dispatch_sync(queue2, ^{
            NSLog(@"执行任务3--%@",[NSThread currentThread]);
        });

        NSLog(@"执行任务4--%@",[NSThread currentThread]);
    });
    NSLog(@"执行任务5--%@",[NSThread currentThread]);
}
- (void)interview7{
    NSLog(@"执行任务1--%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2--%@",[NSThread currentThread]);
        dispatch_sync(queue, ^{//不会死锁，因为是并发队列，允许同时执行任务
            NSLog(@"执行任务3--%@",[NSThread currentThread]);
        });
        NSLog(@"执行任务4--%@",[NSThread currentThread]);
    });
    NSLog(@"执行任务5--%@",[NSThread currentThread]);
    // 15234
}
/***重点***/
- (void)interview8{
    NSLog(@"执行任务1--%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2--%@",[NSThread currentThread]);// 开启新线程没有定义名字，所以输出为空
    });
    sleep(3);//sleep()函数阻塞的是当前进程。
    dispatch_sync(queue, ^{
        NSLog(@"执行任务3--%@",[NSThread currentThread]);
    });
    NSLog(@"执行任务4--%@",[NSThread currentThread]);
}
/***重点***/
- (void)interview9{
    NSLog(@"执行任务1--%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);// 同步在当前线程，异步在新线程
    dispatch_async(queue, ^{
        NSLog(@"执行任务2--%@",[NSThread currentThread]);// 开启新线程没有定义名字，所以输出为空
    });
}
/***重点***/
- (void)interview10{
    NSLog(@"执行任务1--%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);// 同步在当前线程，异步在新线程
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; ++i) {
            NSLog(@"执行任务2--%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; ++i) {
            NSLog(@"执行任务3--%@",[NSThread currentThread]);
        }
    });
}
@end
