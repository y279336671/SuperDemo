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
//#import "ExposureViewController.h"
@interface ViewController ()
@property (nonatomic, strong)Person *person;
//@property(nonatomic, copy) int (^testBlcok)(int n);
@property (nonatomic, strong)Person *personNSTimer;
@property (copy, nonatomic) dispatch_block_t block;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"测试函数地址1");
//    NSLog(@"测试函数地址2");
//    int double_num_times_asm(int num, int times);
    // 1. 0x00000001002d0000
    // 2. 0x00000001028bc000        0x1028c4200      00008020
    //0x00000001005e0000+0x8020
//    [self.view setBackgroundColor:UIColor.redColor];
//    [self taggedpointerDemo];
//    [self exeBlock];


//    [self interview1];
//    [self interview2];
//    [self interview3];
//    [self interview4];
//    [self interview5];
//    [self interview6];
//    [self interview7];
//    [self interview8];
//    [self interview9];
    [self interview10];
//    [self testKVO];

//    [self testCopyAndMutableCopy];

//    self.personNSTimer = [[Person alloc] initWithName:@"测试timer 循环引用问题"];
    self.block = ^{
        NSLog(@"%@", self);
    };
}

-(void)testCopyAndMutableCopy{
    // 1. 可变数组 mutableCopy
//    可变数组的mutableCopy是深拷贝，创建新的数组指针，但是内部的内容不会被重新创建,数组内部的对象引用计数器+1，地址不变
    Person *person = [[Person alloc] init];
    person.age = 1;
    Person *person1 = [[Person alloc] init];
    person1.age = 2;
    Person *person2 = [[Person alloc] init];
    person2.age = 3;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:person];
    [array addObject:person1];
    [array addObject:person2];
    id mutableObject =  [array mutableCopy]; // 可变数组的指针会被复制，但是内部的对象类型的值不会
    Person *temp = array[0];
    temp.age = 4;
    NSLog(@"%@,%@",array,mutableObject);

}

// 多次对同一个属性kvo，只是多次创建了不同的子类，所以会执行多次
-(void)testKVO{
    self.person = [[Person alloc] init];
    self.person.sex = @"girl";
    [self.person addObserver:self forKeyPath:@"sex" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"unknow"];
    [self.person addObserver:self forKeyPath:@"sex" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"unknow1"];
    [self.person addObserver:self forKeyPath:@"sex" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"unknow2"];
    [self.person addObserver:self forKeyPath:@"sex" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"unknow3"];
    self.person.sex = @"boy";
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    NSLog(@"old >>>>> %@",change[NSKeyValueChangeOldKey]);
    NSLog(@"new >>>>> %@",change[NSKeyValueChangeNewKey]);
    NSLog(@"context >>>> %@",context);
}

- (void)interview1{
    NSLog(@"0---%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"1---%@",[NSThread currentThread]);
        [self performSelector:@selector(test1) withObject:nil afterDelay:.0f];
        NSLog(@"3---%@",[NSThread currentThread]);
    });
}
- (void)test1{
    NSLog(@"2---%@",[NSThread currentThread]);
}

- (void)interview2{
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1---%@",[NSThread currentThread]);
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
        dispatch_sync(queue, ^{
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
        NSLog(@"执行任务3--%@",[NSThread currentThread]); //同步提交到串行队列上，不会死锁，同步提交到主队列上才会死锁。
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
