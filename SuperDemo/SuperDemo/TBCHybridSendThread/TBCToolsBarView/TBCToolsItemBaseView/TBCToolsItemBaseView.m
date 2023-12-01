//
//  TBCToolsItemView.m
//  SuperDemo
//
//  Created by yanghe04 on 2023/8/2.
//  Copyright © 2023 yanghe. All rights reserved.
//

#import "TBCToolsItemBaseView.h"

@interface TBCToolsItemBaseView()

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

- (void)initToolsItemBaseViewSubViews {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked)];
    [self addGestureRecognizer:tap];
    
    [self setBackgroundColor:[UIColor yellowColor]];
}

- (void)itemClicked {
    NSLog(@">>>>>>> 请实现协议中的itemClicked");
}

@end
