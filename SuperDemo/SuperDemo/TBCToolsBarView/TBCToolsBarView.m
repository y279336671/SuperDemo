//
//  TBCToolsBarView.m
//  SuperDemo
//
//  Created by yanghe04 on 2023/8/2.
//  Copyright © 2023 yanghe. All rights reserved.
//

#import "TBCToolsBarView.h"
#import "TBCImgToolsItemView.h"
#import "TBCBubbleToolsItemView.h"

@interface TBCToolsBarView () <TBCToolsItemBaseViewDelegate>

@property (nonatomic, strong)TBCImgToolsItemView *imgItemView;
@property (nonatomic, strong)TBCBubbleToolsItemView *bubbleToolsItemView;
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
    [self addSubview:self.bubbleToolsItemView];
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
        _imgItemView = [[TBCImgToolsItemView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _imgItemView.delegate = self;
    }
    return _imgItemView;
}

- (TBCBubbleToolsItemView *)bubbleToolsItemView {
    if (!_bubbleToolsItemView) {
        _bubbleToolsItemView = [[TBCBubbleToolsItemView alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
        _bubbleToolsItemView.delegate = self;
    }
    return _bubbleToolsItemView;
}

@end
