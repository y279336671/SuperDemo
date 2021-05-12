//
// Created by admin on 2021/4/13.
// Copyright (c) 2021 yanghe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VideoDownLoader : NSObject

+ (instancetype)sharedInstance;

-(void)startWithUrls:(NSArray *)urls;
-(void)startWithUrl:(NSString *)url;

// 获取本地文件路径，如果没有返回@""
-(NSString *)filePathWithUrl:(NSString *)url;


@end
