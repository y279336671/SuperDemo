//
//  BlockSubClassViewController.m
//  SuperDemo
//
//  Created by admin on 2021/2/13.
//  Copyright © 2021 yanghe. All rights reserved.
//

#import "BlockSubClassViewController.h"

@interface BlockSubClassViewController ()

@end

@implementation BlockSubClassViewController

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.videoViewDisMiss) {
        self.videoViewDisMiss(YES);
    }
    // Do any additional setup after loading the view.
}
- (void)dealloc {
    NSLog(@"%@   dealloc", NSStringFromClass([self class]));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
