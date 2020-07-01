//
//  ViewController.m
//  SuperDemo
//
//  Created by yanghe on 2020/6/21.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSObject *object1 = [[NSObject alloc]init];
//    NSObject *object2 = [[NSObject alloc]init];
//    if([object1 isEqual:object2]){
//        NSLog(@"isEqual");
//    }

    NSString *str1= @"1";
    NSString *str2= @"2";
    NSString *str3 = @"1";
    if([str1 isEqual:str2]){
        NSLog(@">>>>isEqual");
    }

    if([str1 isEqual:str3]){
        NSLog(@"isEqual<<<<<");
    }

//    TestOC *test1 = [[TestOC alloc] init];
//    TestOC *test2 = [[TestOC alloc] init];
//
//    if([test1 isEqual:test2]){
//        NSLog(@"isEqual");
//    }
//    if(test1 == test2){
//        NSLog(@"isEqual");
//    }
}


@end
