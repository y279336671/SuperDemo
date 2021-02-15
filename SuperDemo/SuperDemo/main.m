//
//  main.m
//  SuperDemo
//
//  Created by yanghe on 2020/6/21.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
//        NSObject *objc = [[NSObject alloc]init];
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}


//#import "Person.h"
//#import "ViewController.h"
//
//int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        MJBlock block;
//        {
//            Person *person = [[Person alloc] init];
//            person.name = @"hahah";
//            NSLog(@"block = %@", [block class]);
//            block = ^{
//                NSLog(@"---------%@", person.name);  // ARC环境下 block会被复制到堆上，堆上的block会持有person，所以person在大括号结束后不会释放，必须执行完block以后才释放
//            };
//            NSLog(@"block = %@", [block class]);
//        }
//        NSLog(@"------"); //breakpoint->
//    }
//}
