//
//  TBCImgToolsItemView.m
//  SuperDemo
//
//  Created by yanghe04 on 2023/8/2.
//  Copyright © 2023 yanghe. All rights reserved.
//

#import "TBCImgToolsItemView.h"
#import "TBCImgToolsItemPresenter.h"

@interface TBCImgToolsItemView () 
@property (nonatomic, strong) TBCImgToolsItemPresenter *presenter;
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

#pragma mark -- TBCToolsItemBaseViewProtocol

- (NSString *)setItemBgImgName {
    NSLog(@"1111");
    return @"11111";
}

- (void)itemClicked {
    NSLog(@">>>>>>>22 %@", NSStringFromClass([self class]));
    [self.presenter fetchImgData];
}

#pragma mark -- init

- (TBCImgToolsItemPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[TBCImgToolsItemPresenter alloc] initWithView:self];
    }
    return _presenter;
}
@end
