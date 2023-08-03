//
//  TBCToolsItemView.m
//  SuperDemo
//
//  Created by yanghe04 on 2023/8/2.
//  Copyright © 2023 yanghe. All rights reserved.
//

#import "TBCToolsItemBaseView.h"

@interface TBCToolsItemBaseView()

/// 可用状态
@property (nonatomic, assign) BOOL enable;

/// 背景图片name
@property (nonatomic, strong) NSString *itemBgImgName;

/// item size
@property (nonatomic, assign) CGSize itemSize;

@end

@implementation TBCToolsItemBaseView

- (instancetype)init {
    if (self = [super init]) {
        [self initToolsItemBaseViewSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initToolsItemBaseViewSubViews];
    }
    return self;
}

- ( void)initToolsItemBaseViewSubViews {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClicked)];
    [self addGestureRecognizer:tap];
    
    NSLog(@"??????%@", self.itemBgImgName);
}

- (void)viewClicked {
    self.delegate 
}

@end
