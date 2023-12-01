//
//  TBCImgToolsItemPresenter.m
//  SuperDemo
//
//  Created by yanghe04 on 2023/8/8.
//  Copyright © 2023 yanghe. All rights reserved.
//

#import "TBCImgToolsItemPresenter.h"
@interface TBCImgToolsItemPresenter ()

@property (nonatomic, weak) id<TBCToolsItemBaseViewProtocol> view;

@end

@implementation TBCImgToolsItemPresenter
/// 初始化View
- (instancetype)initWithView:(id)view {
    self = [super init];
    if (self) {
        // 绑定View
        self.view = view;
    }
    return self;
}

- (void)fetchImgData {
    
}

@end
