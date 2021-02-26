//
//  MemoryDemoViewController.h
//  SuperDemo
//
//  Created by yanghe on 2020/7/26.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface HTPerson : NSObject
@property (nonatomic, copy) NSString *name;
- (void)sayHello;
@end


@interface MemoryDemoViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
