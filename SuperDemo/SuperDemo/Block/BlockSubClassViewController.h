//
//  BlockSubClassViewController.h
//  SuperDemo
//
//  Created by admin on 2021/2/13.
//  Copyright © 2021 yanghe. All rights reserved.
//

#import "BlockViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BlockSubClassViewController : BlockViewController
@property (nonatomic, copy) void (^videoViewDisMiss)(BOOL agree);
@end

NS_ASSUME_NONNULL_END
