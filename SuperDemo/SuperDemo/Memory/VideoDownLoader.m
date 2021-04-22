//
// Created by admin on 2021/4/13.
// Copyright (c) 2021 yanghe. All rights reserved.
//

#import "VideoDownLoader.h"
@interface VideoDownLoader (){
    dispatch_semaphore_t _semaphore;
    NSInteger _threadCount;
    dispatch_queue_t _downloaderQueue;
    NSArray *_urls;
}
@end

@implementation VideoDownLoader

-(id)initWithURLs:(NSArray *)urls{
    self = [super init];
    _threadCount = 5;
    _semaphore = dispatch_semaphore_create(_threadCount);
    _downloaderQueue =  dispatch_queue_create("com.yanghe.video.cache", DISPATCH_QUEUE_CONCURRENT);
    _urls = urls;
    return  self;
}

-(void)start{
    for (int i = 0; i < _urls.count; ++i) {
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(_downloaderQueue, ^{

            NSLog(@"[NSThread currentThread] = %@", [NSThread currentThread]);
            dispatch_semaphore_signal(_semaphore);
        });
    }
}

@end