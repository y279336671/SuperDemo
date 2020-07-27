//
//  ViewController.m
//  SuperDemo
//
//  Created by yanghe on 2020/6/21.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import <objc/runtime.h>
#import "ViewController.h"
#import "Person.h"
#import "Person+man.h"
#import "MemoryDemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.redColor];

    [self memoryDemo];

//    unsigned int outCount = 0;
//    objc_property_t* propertys = class_copyPropertyList([Person class], &outCount);
//    for (unsigned i = 0; i < outCount; i++) {
//        objc_property_t property = propertys[i];
//        assert(property != nil);
//        const char* name = property_getName(property);
//        NSLog(@"name: %s", name);
//
//        NSString* attrs = @(property_getAttributes(property));
//        NSLog(@"code: %@", attrs);
//    }


//    Person *person = [[Person alloc] init];
//    [person performSelector:@selector(hahaha)];
//    person.sex = @"man";
//    property_getAttributes(person.sex);

//    NSLog(@">>>%@<<<",person.sex);

//    NSString *str1 = [[NSString alloc] initWithString:@"123"];
//
//
//    NSString *str2 = @"123";
//
//    NSLog(@"%@%@",str1,str2);
//    [self memoryDemo];
}

//测试timer
-(void)memoryDemo{
    UIButton *memoryDemo = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [memoryDemo addTarget:self action:@selector(showMemoryDemo) forControlEvents:UIControlEventTouchUpInside];
    [memoryDemo setTitle:@"memory" forState:UIControlStateNormal];
    [self.view addSubview:memoryDemo];
}
-(void)showMemoryDemo{
    MemoryDemoViewController *memoryDemo = [[MemoryDemoViewController alloc] init];
    [memoryDemo.view setBackgroundColor:UIColor.yellowColor];
    [self.navigationController pushViewController:memoryDemo animated:YES];
}
@end
