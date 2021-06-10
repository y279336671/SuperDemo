//
// Created by admin on 2021/4/13.
// Copyright (c) 2021 yanghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYDispatchQueuePool.h>
#import "VideoDownLoader.h"
@interface VideoDownLoader ()
@property(nonatomic, strong)  NSMutableArray *downloadingURLs;
@property(nonatomic, strong)  dispatch_semaphore_t semaphore;
@end

@implementation VideoDownLoader

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillShutdown) name:UIApplicationWillTerminateNotification object:nil];// 杀死app的时候清空所有视频缓存
    }
    return self;
}

static id _sharedInstance = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });

    return _sharedInstance;
}

-(NSString *)filePathWithUrl:(NSString *)url{
    //判断本地是否已经下载完成，如果是下载中这个方法也返回  @""
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:[self createFilePath]];
    NSURL *fileURL = [documentsDirectoryURL URLByAppendingPathComponent:[[NSURL URLWithString:url] lastPathComponent]];
    if ([fileManager fileExistsAtPath:[fileURL path] isDirectory:NULL]) {
        return  [fileURL path];
    }
    return @"";
}

-(NSString *)createFilePath{
    //判断本地是否已经下载完成，如果是下载中这个方法也返回  @""
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dataFilePath = [documentsPath stringByAppendingPathComponent:@"videofiles"];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
    if (!(isDir && existed)) {
        // 在Document目录下创建一个videofiles目录
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }

    return dataFilePath;
}

- (void)startWithUrls:(NSArray *)urls {


    if (!urls || urls.count == 0) return;

    @autoreleasepool {
        NSURLSession *session = [NSURLSession sharedSession];
        __weak typeof(self) weakSelf = self;

        for (int i = 0; i < urls.count; ++i) {
            NSString *url = urls[i];

            if(url&&url.length>0&&[self filePathWithUrl:url].length==0&&![self isDownloading:url]){ // 下载中不下载   本地存在不下载

                dispatch_semaphore_wait(self.semaphore,DISPATCH_TIME_FOREVER);
                [self.downloadingURLs addObject:url];// 开始下载添加到下载中数组
                dispatch_semaphore_signal(self.semaphore);

                NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[NSURL URLWithString:urls[i]] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                    //移动到Documents文件夹下
                    if(!error){
                        NSFileManager *fileManager = [NSFileManager defaultManager];
                        NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:[weakSelf createFilePath]];
                        NSURL *fileURL = [documentsDirectoryURL URLByAppendingPathComponent:[[response URL] lastPathComponent]];
                        if (![fileManager fileExistsAtPath:[fileURL path] isDirectory:NULL]) {
                            [fileManager moveItemAtURL:location toURL:fileURL error:NULL];
                        }
                    }
                    NSLog(@"response absoluteString= %@", response.URL.absoluteString);
                    dispatch_semaphore_wait(weakSelf.semaphore,DISPATCH_TIME_FOREVER);
                    [weakSelf.downloadingURLs removeObject:url]; //下载完成后移除
                    NSLog(@"weakSelf.downloadingURLs.count = %lu", weakSelf.downloadingURLs.count);
                    dispatch_semaphore_signal(weakSelf.semaphore);
                }];
                [task resume];
            }
        }
    }
}



- (void)startWithUrl:(NSString *)url {
    if (!url || url.length == 0||[self filePathWithUrl:url].length>0)
        return;

    [self startWithUrls:@[url]];
}

-(BOOL)isDownloading:(NSString *)url{
    dispatch_semaphore_wait(self.semaphore,DISPATCH_TIME_FOREVER);
    BOOL downloading = [self.downloadingURLs containsObject:url];// 判断是否在下载中
    dispatch_semaphore_signal(self.semaphore);
    return downloading;
}

-(void)applicationWillShutdown{
    //  杀死app的时候清空所有视频缓存
    BOOL removeScuess =[[NSFileManager defaultManager] removeItemAtPath:[self createFilePath] error:NULL];
    NSLog(@"removeScuess = %d", removeScuess);
}

- (NSMutableArray *)downloadingURLs {
    if (!_downloadingURLs) {
        _downloadingURLs = [[NSMutableArray alloc] init];
    }
    return _downloadingURLs;
}

- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(1);
    }
    return _semaphore;
}


@end
