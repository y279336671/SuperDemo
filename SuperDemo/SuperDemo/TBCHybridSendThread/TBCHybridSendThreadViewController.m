//
//  TBCHybridSendThreadViewController.m
//  SuperDemo
//
//  Created by yanghe04 on 2023/8/7.
//  Copyright © 2023 yanghe. All rights reserved.
//
/// iPhone X底部非安全区域高度
///


#import "TBCHybridSendThreadViewController.h"
#import <YogaKit/YogaKit-umbrella.h>
@interface TBCHybridSendThreadViewController ()

@end

@implementation TBCHybridSendThreadViewController
- (void)injected{

    [self viewWillAppear:YES];

    [self viewDidLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //container 元素
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn; //主轴方向 左 -> 右
    }];
    UIView *view1 = [UIView new];
    [view1 setBackgroundColor:[UIColor yellowColor]];
    
    UIView *view2 = [UIView new];
    [view2 setBackgroundColor:[UIColor grayColor]];
//    UIView *view3 = [UIView new];
//    [view3 setBackgroundColor:[UIColor greenColor]];
    
    
    [self.view addSubview:view1];
    [view1 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue([UIScreen mainScreen].bounds.size.width);
        layout.height = YGPointValue(88);
    }];
    [self.view addSubview:view2];
    [view2 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue([UIScreen mainScreen].bounds.size.width);
        layout.height = YGPointValue([UIScreen mainScreen].bounds.size.height - 88);
        layout.flexDirection = YGFlexDirectionRow;
    }];
//    [self.view addSubview:view3];
//    [view3 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
//        layout.isEnabled = YES;
//        layout.width = YGPointValue(100);
//        layout.height = YGPointValue(100);
//        layout.bottom = YGPointValue(0);
//    }];

    
    //使用原点布局?
    [self.view.yoga applyLayoutPreservingOrigin:NO];
    
    // Do any additional setup after loading the view.
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
