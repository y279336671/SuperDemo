//
//  ViewController.m
//  SuperDemo
//
//  Created by yanghe on 2020/6/21.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import "ViewController.h"
#import "TestOC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSObject *object1 = [[NSObject alloc]init];

    NSObject *object2 = [[NSObject alloc]init];

    UIColor *color1 = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    TestOC *testOc1 = [[TestOC alloc] init];
    TestOC *testOc2= [[TestOC alloc] init];

    if(testOc1==testOc2){
        NSLog(@"==");
    }
    if([color1 isEqual:color2]){
        NSLog(@"isEqual");
    }
//    if([object1 isMemberOfClass:[testOc class]]){
//        NSLog(@"isMemberOfClass");
//    }
//    if([testOc isKindOfClass:[object1 class]]){
//        NSLog(@"isKindOfClass");
//    }
    // Do any additional setup after loading the view.
}


@end
