//
//  AppDelegate.m
//  SuperDemo
//
//  Created by yanghe on 2020/6/21.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "TaggedPointerViewController.h"
#import "Multithread/MultithreadingViewController.h"
//#import "ExposureViewController.h"
//#import <Aspects.h>
//#import <Aspects/Aspects.h>
#import "Memory/MemoryDemoViewController.h"
#import "AutoKVO/AutoKVO.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}




@end
