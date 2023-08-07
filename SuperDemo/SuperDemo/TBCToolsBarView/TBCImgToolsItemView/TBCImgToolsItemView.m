//
//  TBCImgToolsItemView.m
//  SuperDemo
//
//  Created by yanghe04 on 2023/8/2.
//  Copyright © 2023 yanghe. All rights reserved.
//

#import "TBCImgToolsItemView.h"

@interface TBCImgToolsItemView () 

@end

@implementation TBCImgToolsItemView

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


#pragma mark -- 重写下面方法定制界面

- (NSString *)itemBgImgName {
    return @"11111";
}

- (CGSize)itemSize {
    return CGSizeMake(100, 100);
}

- (BOOL)enable {
    return YES;
}

- (void)itemClicked {
    NSLog(@">>>>>>itemClicked");
}

@end
