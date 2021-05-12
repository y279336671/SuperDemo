//
// Created by admin on 2021/3/30.
// Copyright (c) 2021 yanghe. All rights reserved.
//

#import "MemorySubViewController.h"
#import "VideoDownLoader.h"
#import <YYDispatchQueuePool.h>
#import <YYKit/YYDispatchQueuePool.h>

@interface MemorySubViewController ()
@property(strong, nonatomic) VideoDownLoader *downLoader;
@end

@implementation MemorySubViewController
- (void)viewDidLoad {
    [super viewDidLoad];


//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeEvent) userInfo:nil repeats:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

//    dispatch_queue_t queue = YYDispatchQueueGetForQOS(NSQualityOfServiceUtility);
//
//    for (int i = 0; i < 20; ++i) {
//        dispatch_async(queue, ^{
//            sleep(5);
//            NSLog(@"[NSThread currentThread] = %@", [NSThread currentThread]);
//        });
//    }


NSArray *array = @[@"https://vc9-al1-pl-agv.autohome.com.cn/video-34/9C9DF5843CD64975/2021-04-23/15D701CF9125DC546F15C4841F4F2CE2-200.mp4",
        @"https://n13-pl-agv.autohome.com.cn/video-12/9C9DF5843CD64975/2019-09-27/9AA017C23DDAB6306F15C4841F4F2CE2-200.mp4",
        @"https://n13-pl-agv.autohome.com.cn/video-6/9C9DF5843CD64975/2019-08-28/4E86C5A8E75307576F15C4841F4F2CE2-200.mp4",
        @"https://n13-pl-agv.autohome.com.cn/video-19/9C9DF5843CD64975/2019-08-19/940715B8E20812136F15C4841F4F2CE2-200.mp4",
        @"https://vc8-al1-pl-agv.autohome.com.cn/video-36/9C9DF5843CD64975/2021-03-06/2B4394A05A8BE2516F15C4841F4F2CE2-200.mp4",
        @"https://vc9-al1-pl-agv.autohome.com.cn/video-33/9C9DF5843CD64975/2021-05-05/A38ADCACB08599F16F15C4841F4F2CE2-200.mp4",
        @"https://vc8-al1-pl-agv.autohome.com.cn/video-33/9C9DF5843CD64975/2021-01-15/48DF3454D6E2C7916F15C4841F4F2CE2-200.mp4",
        @"https://vc9-al1-pl-agv.autohome.com.cn/video-31/9C9DF5843CD64975/2021-04-19/64BCAF1E926C9D506F15C4841F4F2CE2-200.mp4"
      ];
NSArray *array1 = @[  @"https://n35-pl-agv.autohome.com.cn/video-13/9C9DF5843CD64975/2020-11-22/A24D88BA6250F3A86F15C4841F4F2CE2-200.mp4",
        @"https://vc8-al1-pl-agv.autohome.com.cn/video-30/9C9DF5843CD64975/2020-12-28/C0108FBFC57A7E4E6F15C4841F4F2CE2-200.mp4",
        @"https://vc9-al1-pl-agv.autohome.com.cn/video-13/9C9DF5843CD64975/2021-04-21/4751FAAD1E199C886F15C4841F4F2CE2-200.mp4",
        @"https://vc9-al1-pl-agv.autohome.com.cn/video-19/9C9DF5843CD64975/2021-04-08/254603548C654B6C6F15C4841F4F2CE2-200.mp4",
        @"https://vc9-al1-pl-agv.autohome.com.cn/video-17/9C9DF5843CD64975/2021-04-28/A408CC2CB90651C06F15C4841F4F2CE2-200.mp4",
        @"https://vc9-al1-pl-agv.autohome.com.cn/video-49/9C9DF5843CD64975/2021-03-25/97B9830752BC3C346F15C4841F4F2CE2-200.mp4",
        @"https://n13-pl-agv.autohome.com.cn/video-47/9C9DF5843CD64975/2019-08-21/B86331ADD895F6DD6F15C4841F4F2CE2-200.mp4"];

     VideoDownLoader *downLoader = [VideoDownLoader sharedInstance];
    [downLoader startWithUrls:array];
    [downLoader startWithUrls:array1];
//    [downLoader startWithUrl:@"https://vc9-al1-pl-agv.autohome.com.cn/video-49/9C9DF5843CD64975/2021-03-25/97B9830752BC3C346F15C4841F4F2CE2-200.mp4"];
//    NSLog(@"downLoader = %@", [downLoader filePathWithUrl:@"https://vc9-al1-pl-agv.autohome.com.cn/video-49/9C9DF5843CD64975/2021-03-25/97B9830752BC3C346F15C4841F4F2CE2-200.mp4"]);

}


- (void)dealloc {
    NSLog(@"NSStringFromClass([self class]) = %@", NSStringFromClass([self class]));
}

@end