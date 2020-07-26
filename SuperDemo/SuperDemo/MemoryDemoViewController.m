//
//  MemoryDemoViewController.m
//  SuperDemo
//
//  Created by yanghe on 2020/7/26.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import "MemoryDemoViewController.h"
#import "YHProxy.h"
@interface MemoryDemoViewController ()
@property (strong, nonatomic) CADisplayLink *link;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation MemoryDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 保证调用频率和屏幕的刷帧频率一致，60FPS
    self.link = [CADisplayLink displayLinkWithTarget:[YHProxy proxyWithTarget:self] selector:@selector(linkTest)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[YHProxy proxyWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];

    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf timerTest];
    }];
}

- (void)timerTest
{
    NSLog(@"%s", __func__);
}

- (void)linkTest
{
    NSLog(@"%s", __func__);
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    [self.link invalidate];
//    [self.timer invalidate];
}

@end
