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

- (NSString *)itemBgImgName {
    return @"22222";
}

//- (CGSize)itemSize {
//    return CGSizeMake(200, 200);
//}

- (BOOL)enable {
    return YES;
}

- (void)itemClicked {
    NSLog(@">>>>>>itemClicked");
}

@end
