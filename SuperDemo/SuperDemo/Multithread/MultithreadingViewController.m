//
//  MultithreadingViewController.m
//  SuperDemo
//
//  Created by admin on 2020/11/18.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import <NSArray+YYAdd.h>
#import "MultithreadingViewController.h"
#import "YHSafeMutableArray.h"
#import "YHThreadSafeMutableArray.h"

@interface MultithreadingViewController ()
@property(nonatomic, strong) NSString *name;

@property(nonatomic, strong) YHSafeMutableArray *safeMutableArray;
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
//    [self interview6];
//    [self interview7];
//    [self interview8];
//    [self interview9];
//    [self interview10];
//    [self interview12];
//    [self interview13];
//    [self interview14];
//    [self interview15];

// 多任务同步相关
    //[self interview16]; //利用dispatch_group_t dispatch_queue_t  -> dispatch_group_async(group,queue,block)   -> dispatch_group_notify(group,queue,block)
    //[self interview17];  //  block 执行前 -> dispatch_group_enter -> block 执行后-> dispatch_group_leave    -> dispatch_group_notify(group,mainqueue,block)
    //[self interview18]; //利用NSOperation   NSOperationQueue -> NSBlockOperation1 NSBlockOperation2 NSBlockOperation3 ->  NSBlockOperation3 addDependency 1和2 -> 1 2 3 都加入到NSOpertaion的队列中
    //[self interview19]; //信号量

   //线程安全数组的几种实现方式
    [self interview20];
    [self interview21];
    [self interview22];
}
-(void)interview22{
    //串行队列 ，就是把数组所有方法都加到 串行队列中
//    dispatch_queue_t serialQueue = dispatch_queue_create("Dan-serial", DISPATCH_QUEUE_SERIAL);

//        dispatch_async(serialQueue, ^{
//            // 这里面放入数组操作内容
//        });

}
-(void)interview21{
// 信号量加锁的方式,如 YYThreadSafeArray
// 在初始化方法里面初始化一个_lock = dispatch_semaphore_create(1);的锁，
// 然后每个方法里面都加锁  dispatch_semaphore_wait()   和 dispatch_semaphore_signal()

}
-(void)interview20{
// dispatch_barrier_async实现    关键点是
// 读取操作是用dispatch_sync(concurrentQueue,block)
// 写操作是dispatch_barrier_async(concurrentQueue,block)  必须在同一个队列中。

}
-(void)interview19{
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    for (int i = 0; i < 10; ++i) {
        dispatch_async(globalQueue, ^{
            NSLog(@"[NSThread currentThread] = %@", [NSThread currentThread]);
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }

    dispatch_async(globalQueue, ^{
        NSLog(@"[NSThread currentThread] end = %@", [NSThread currentThread]);
    });

}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}
/**
 * 使用NSOperation到达多任务同步
 * 1. 声明一个operation queue
 * 2. 声明 operation block。每个block是一个任务
 * 3. 将要最后执行的任务添加上依赖，也就说 最后的任务 依赖于其他任务都执行完成
 * 4. 把任务都添加到operation queue中
 */
-(void)interview18{
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 任务1
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://img-blog.csdn.net/20180421152137506"]];
        NSLog(@"任务1 完成，线程：%@", [NSThread currentThread]);
    }];

    // 任务2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://img-blog.csdn.net/20170112145924755?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGVyb193cWI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center"]];
        NSLog(@"任务2 完成，线程：%@", [NSThread currentThread]);
    }];

    // 任务3
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务3 完成，线程：%@", [NSThread currentThread]);
    }];
    // 添加操作依赖，注意不能循环依赖
    [op1 addDependency:op2];
    [op1 addDependency:op3];

    op1.completionBlock = ^{
        NSLog(@"全部完成，线程：%@", [NSThread currentThread]);
    };

    // 添加操作到队列
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}

- (void)interview17 {
    NSURLSession *session = [NSURLSession sharedSession];
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    // 任务1
    dispatch_group_enter(group);
    NSURLSessionDataTask *task1 = [session dataTaskWithURL:[NSURL URLWithString:@"https://www.apple.com/105/media/us/imac-pro/2018/d0b63f9b_f0de_4dea_a993_62b4cb35ca96/hero/large.mp4"] completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        NSLog(@"任务1 完成，线程：%@", [NSThread currentThread]);
        dispatch_group_leave(group);
    }];
    [task1 resume];

    // 任务2
    dispatch_group_enter(group);
    NSURLSessionDataTask *task2 = [session dataTaskWithURL:[NSURL URLWithString:@"https://www.apple.com/105/media/us/imac-pro/2018/d0b63f9b_f0de_4dea_a993_62b4cb35ca96/thumbnails/erin-sarofsky/large.mp4"] completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        NSLog(@"任务2 完成，线程：%@", [NSThread currentThread]);
        dispatch_group_leave(group);
    }];
    [task2 resume];
    // 全部完成
    dispatch_group_notify(group, dispatch_get_main_queue(), ^() {
        NSLog(@"全部完成，线程：%@", [NSThread currentThread]);
    });
}

/**
 * 等待多个任务完成后，再执行任务       注意如果任务本身就是异步的，interview16是无法瞒住需求的要使用interview17
 * 1. 创建并发队列 queue
 * 2. 创建group组 group
 * 3. dispatch_group_async(group,queue,block)
 * 4. dispatch_group_notify(group,queue,block)
**/
- (void)interview16 {
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    // 创建并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // 开子线程，任务1
    dispatch_group_async(group, queue, ^{
        [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://img-blog.csdn.net/20180421152137506"]];
        NSLog(@"任务1 完成，线程：%@", [NSThread currentThread]);
    });
    // 开子线程，任务2
    dispatch_group_async(group, queue, ^{
        [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://img-blog.csdn.net/20170112145924755?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvaGVyb193cWI=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center"]];
        NSLog(@"任务2 完成，线程：%@", [NSThread currentThread]);
    });
    // 全部完成
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"全部完成，线程：%@", [NSThread currentThread]);
        });
    });
}

- (void)interview1 {

    NSLog(@"0---%@", [NSThread currentThread]);
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);// 全局队列是并发队列
    dispatch_async(queue, ^{
        NSLog(@"1---%@", [NSThread currentThread]);
        //GNUstep  -> NSFuncation  源码
        [self performSelector:@selector(test1) withObject:nil afterDelay:.0f];////默认GCD不会启动runloop，afterDelay需要runloop支持，及时是0秒也是先输出 1 3 2，因为一般是runloop再次 被唤醒的时候才执行test1方法
        NSLog(@"3---%@", [NSThread currentThread]);
        //[NSRunLoop currentRunLoop] 获取当前线程的runloop，注意是当前线程，如果当前线程没有runloop就创建
//        // 添加以下两行才能执行
//        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
//        // 只添加这一行也可以，因为performSelector底层已经被加入runloop，只是没有启动
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

//        同理NSTimer 也不能执行
    });

//    以下代码输出是 132，在主线程中默认有runloop。 runloop何时去处理timer事件？？？？？？？？？？？、
//    NSLog(@"1---%@",[NSThread currentThread]);
//    [self performSelector:@selector(test1) withObject:nil afterDelay:.0f];
//    NSLog(@"3---%@",[NSThread currentThread]);
}

- (void)test1 {
    NSLog(@"2---%@", [NSThread currentThread]);
}

- (void)interview2 {
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1---%@", [NSThread currentThread]);
//        //        // 添加以下两行才能执行
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
////         只添加这一行也可以，因为performSelector底层已经被加入runloop，只是没有启动
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }];
    [thread start];
    [self performSelector:@selector(test2) onThread:thread withObject:nil waitUntilDone:YES];
}

- (void)test2 {
    NSLog(@"2---%@", [NSThread currentThread]);
}

- (void)interview3 {
    NSLog(@"执行任务1--%@", [NSThread currentThread]);
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{   //死锁
        NSLog(@"执行任务2--%@", [NSThread currentThread]);
    });
    NSLog(@"执行任务3--%@", [NSThread currentThread]);
}

- (void)interview4 {
    NSLog(@"执行任务1--%@", [NSThread currentThread]);
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"执行任务2--%@", [NSThread currentThread]);
    });
    NSLog(@"执行任务3--%@", [NSThread currentThread]);
}

- (void)interview5 {
    NSLog(@"执行任务1--%@", [NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2--%@", [NSThread currentThread]);
        dispatch_sync(queue, ^{
            NSLog(@"执行任务3--%@", [NSThread currentThread]);
        });
        NSLog(@"执行任务4--%@", [NSThread currentThread]);
    });
    NSLog(@"执行任务5--%@", [NSThread currentThread]);
}

- (void)interview55 {
    NSLog(@"执行任务1--%@", [NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue1 = dispatch_queue_create("myqueu1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2--%@", [NSThread currentThread]);
        dispatch_sync(queue1, ^{
            NSLog(@"执行任务3--%@", [NSThread currentThread]);
        });
        NSLog(@"执行任务4--%@", [NSThread currentThread]);
    });
    NSLog(@"执行任务5--%@", [NSThread currentThread]);
}

- (void)interview6 {
    NSLog(@"执行任务1--%@", [NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("myqueu2", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2--%@", [NSThread currentThread]);

        dispatch_sync(queue2, ^{
            NSLog(@"执行任务3--%@", [NSThread currentThread]);
        });

        NSLog(@"执行任务4--%@", [NSThread currentThread]);
    });
    NSLog(@"执行任务5--%@", [NSThread currentThread]);
}

- (void)interview7 {
    NSLog(@"执行任务1--%@", [NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2--%@", [NSThread currentThread]);
        dispatch_sync(queue, ^{//不会死锁，因为是并发队列，允许同时执行任务
            NSLog(@"执行任务3--%@", [NSThread currentThread]);
        });
        NSLog(@"执行任务4--%@", [NSThread currentThread]);
    });
    NSLog(@"执行任务5--%@", [NSThread currentThread]);
    // 15234
}

/***重点***/
- (void)interview8 {
    NSLog(@"执行任务1--%@", [NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2--%@", [NSThread currentThread]);// 开启新线程没有定义名字，所以输出为空
    });
    sleep(3);//sleep()函数阻塞的是当前进程。
    dispatch_sync(queue, ^{ //不会死锁，因为是提交到了自创建的队列
        NSLog(@"执行任务3--%@", [NSThread currentThread]);
    });
    NSLog(@"执行任务4--%@", [NSThread currentThread]);
}

/***重点***/
- (void)interview9 {
    NSLog(@"执行任务1--%@", [NSThread currentThread]);
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);// 同步在当前线程，异步在新线程
    dispatch_async(queue, ^{
        NSLog(@"执行任务2--%@", [NSThread currentThread]);// 开启新线程没有定义名字，所以输出为空
    });
}

/***重点***/
- (void)interview10 {
    NSLog(@"执行任务1--%@", [NSThread currentThread]);
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);// 同步在当前线程，异步在新线程
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; ++i) {
            NSLog(@"执行任务2--%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; ++i) {
            NSLog(@"执行任务3--%@", [NSThread currentThread]);
        }
    });
}

//-(void)setName:(NSString *)name {
//    if(_name!=name){
//        [_name release];
//        _name = [name retain];
//    }
//}


- (void)interview11 {

// ------------------------------------------------------
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
            // 加锁
            self.name = [NSString stringWithFormat:@"abcdefghijk"];   // 这个位置会崩溃，因为多线程情况下，调用setName方法会造成多次[_name release]，所以会崩溃。
            // 解锁
            // 解决方案:
            // 1. 使用atomic
            // 2. 在这个位置使用锁，这个方式较优

        });
    }

    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);

    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue1, ^{
            self.name = [NSString stringWithFormat:@"abc"];  // 这个位置不会崩溃，因为直接存储在地址中，就不存在 release的过程
        });
    }

//    NSString *str1 = [NSString stringWithFormat:@"abcdefghijk"];
//    NSString *str2 = [NSString stringWithFormat:@"123abc"];

//    NSLog(@"%@ %@", [str1 class], [str2 class]);
//    NSLog(@"%p", str2);
// ------------------------------------------------------
}


- (void)interview12 {
    self.safeMutableArray = [[YHSafeMutableArray alloc] init];
    dispatch_queue_t queue = dispatch_queue_create("test_safe_array", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 20; ++i) {
        dispatch_async(queue, ^{
            [self.safeMutableArray addObject:@"qwe"];
            [self.safeMutableArray addObject:@"qwe"];
            [self.safeMutableArray removeObjectAtIndex:0];
        });
    }
//    NSLog(@"self.safeMutableArray = %@", self.safeMutableArray);
//    NSLog(@"self.safeMutableArray count = %ld", [self.safeMutableArray count]);
//    for (int i = 0; i < 8; ++i) {
//        dispatch_async(queue, ^{
//            [self.safeMutableArray removeFirstObject];
//            NSLog(@"self.safeMutableArray = %@", self.safeMutableArray);
//        });
//    }
//    for (int i = 0; i < 8; ++i) {
//        dispatch_async(queue, ^{
//            NSLog(@"self.safeMutableArray = %ld", [self.safeMutableArray count]);
//        });
//    }
}

- (void)interview13 {
    dispatch_queue_t dispatchQueue = dispatch_queue_create("ted.queue.next1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);

    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_async(dispatchGroup, dispatchQueue, ^() {

        sleep(5);
        NSLog(@"任务一完成");
    });
    dispatch_group_async(dispatchGroup, dispatchQueue, ^() {

        sleep(4);
        NSLog(@"任务二完成");
    });
    dispatch_group_async(dispatchGroup, dispatchQueue, ^() {

        sleep(9);
        NSLog(@"任务三完成");
    });
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^() {
        NSLog(@"notify：任务都完成了");
    });
}

// 重点
- (void)interview14 {
    dispatch_queue_t serialQueue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(serialQueue, ^{  // 不会阻塞线程，往下执行
        NSLog(@"2");
    });
    NSLog(@"3");
    dispatch_sync(serialQueue, ^{ // 阻塞线程，由于是串行队列，先进先出，所以等2执行完，执行4，最后是5
        NSLog(@"4");
    });
    NSLog(@"5");

    // 关键点: async 不会再阻塞线程  sync阻塞线程 串行队列先进先出
    // 13245
}

- (void)interview15 {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(3);
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 100; ++i) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"i = %i", i);
        sleep(2);
        dispatch_semaphore_signal(semaphore);
    }
}

@end
