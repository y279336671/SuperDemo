//
//  ViewController.h
//  SuperDemo
//
//  Created by yanghe on 2020/6/21.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MJBlock) (void);
@interface ViewController : UIViewController

@property(nonatomic, strong) NSString *str;
@property(copy, nonatomic, readonly) MJBlock block;
@end

