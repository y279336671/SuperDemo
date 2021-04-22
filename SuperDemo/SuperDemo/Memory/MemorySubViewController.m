//
// Created by admin on 2021/3/30.
// Copyright (c) 2021 yanghe. All rights reserved.
//

#import "MemorySubViewController.h"
#import "VideoDownLoader.h"

@interface MemorySubViewController ()
@property (strong, nonatomic) VideoDownLoader *downLoader;
@end

@implementation MemorySubViewController
- (void)viewDidLoad {
    [super viewDidLoad];


//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeEvent) userInfo:nil repeats:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

}

//-(void)timeEvent{
//    NSLog(@"timer event");
//}

- (void)dealloc {
    NSLog(@"NSStringFromClass([self class]) = %@", NSStringFromClass([self class]));
}

@end