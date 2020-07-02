//
//  ViewController.m
//  SuperDemo
//
//  Created by yanghe on 2020/6/21.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.whiteColor];


    Person *person = [[Person alloc] init];
    [person initWithName:@"yh"];
    NSLog(@"%@===%@",person.name,person);

}


@end
