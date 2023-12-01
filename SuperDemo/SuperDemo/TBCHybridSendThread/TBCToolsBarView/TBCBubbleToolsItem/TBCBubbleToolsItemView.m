//
//  TBCBubbleToolsItemView.m
//  SuperDemo
//
//  Created by yanghe04 on 2023/8/7.
//  Copyright © 2023 yanghe. All rights reserved.
//

#import "TBCBubbleToolsItemView.h"

@implementation TBCBubbleToolsItemView

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor greenColor]];
    }
    return self;
}


#pragma mark -- 重写下面方法定制界面

- (NSString *)setItemBgImgName {
    NSLog(@"22222");
    return @"22222";
}

- (void)itemClicked {
    NSLog(@">>>>>>>11 %@", NSStringFromClass([self class]));
}

@end
