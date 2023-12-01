//
//  TBCImgToolsItemPresenter.h
//  SuperDemo
//
//  Created by yanghe04 on 2023/8/8.
//  Copyright © 2023 yanghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBCToolsItemBaseViewProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface TBCImgToolsItemPresenter : NSObject

/// 初始化View
- (instancetype)initWithView:(id)view;

- (void)fetchImgData;
@end

NS_ASSUME_NONNULL_END
