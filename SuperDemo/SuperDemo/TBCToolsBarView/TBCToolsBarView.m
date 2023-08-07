//
//  TBCToolsBarView.m
//  SuperDemo
//
//  Created by yanghe04 on 2023/8/2.
//  Copyright © 2023 yanghe. All rights reserved.
//

#import "TBCToolsBarView.h"
#import "TBCImgToolsItemView.h"

@interface TBCToolsBarView () <TBCToolsItemBaseViewDelegate>

@property (nonatomic, strong)TBCImgToolsItemView *imgItemView;

@end


@implementation TBCToolsBarView

- (instancetype)init {
    if (self = [super init]) {
        [self setupSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:self.imgItemView];
}


#pragma mark -- TBCToolsItemBaseViewProtocol

- (void)itemView:(TBCToolsItemBaseView *)itemView businessData:(id)data {
    NSLog(@"%@,%@", itemView, data);
}

- (void)itemViewClicked:(TBCToolsItemBaseView *)itemView {
    NSLog(@"%@", itemView);
}

#pragma mark -- init

- (TBCImgToolsItemView *)imgItemView {
    if (!_imgItemView) {
        _imgItemView = [[TBCImgToolsItemView alloc] init];
        _imgItemView.delegate = self;
    }
    return _imgItemView;
}



@end
