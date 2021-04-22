//
// Created by admin on 2021/4/13.
// Copyright (c) 2021 yanghe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VideoDownLoader : NSObject
-(id)initWithURLs:(NSArray *)urls;
-(void)start;
@end