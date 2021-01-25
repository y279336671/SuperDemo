//
//  MemoryDemoViewController.m
//  SuperDemo
//
//  Created by yanghe on 2020/7/26.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import "MemoryDemoViewController.h"

#import "MJTimer.h"

@interface MemoryDemoViewController ()
@property (strong, nonatomic) CADisplayLink *link;
@property (strong, nonatomic) NSTimer *timer;
@property (copy, nonatomic) NSString *task;
@end

@implementation MemoryDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
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

