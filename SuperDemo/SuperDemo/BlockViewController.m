//
//  BlockViewController.m
//  SuperDemo
//
//  Created by admin on 2021/2/13.
//  Copyright © 2021 yanghe. All rights reserved.
//

#import "BlockViewController.h"
#import "Person.h"
#import "ViewController.h"

@interface BlockViewController ()
{
    NSString *_name;
}
@end

@implementation BlockViewController
+ (void)initialize {
//    [super initialize];
    NSLog(@"NSStringFromClass([self class]) = %@,initialize", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)dealloc {
    NSLog(@"%@   dealloc", NSStringFromClass([self class]));

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
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
