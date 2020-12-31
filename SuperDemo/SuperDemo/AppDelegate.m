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
#import "MultithreadingViewController.h"
//#import "ExposureViewController.h"
//#import <Aspects.h>
//#import <Aspects/Aspects.h>
#import "MemoryDemoViewController.h"
#import "ManualKVO.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Override point for customization after application launch.

    UIViewController *mainViewController = [[ViewController alloc] init];
    [mainViewController.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [mainViewController.view setBackgroundColor:[UIColor whiteColor]];
    UIViewController *mainNavigationController = [[UINavigationController alloc]
            initWithRootViewController:mainViewController];
    mainNavigationController.title = @"首页";

    UIViewController *multithreadingViewController = [[MultithreadingViewController alloc] init];
    UIViewController *multithreadingNavigationController = [[UINavigationController alloc]
            initWithRootViewController:multithreadingViewController];
    [multithreadingViewController.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [multithreadingViewController.view setBackgroundColor:[UIColor whiteColor]];
    multithreadingNavigationController.title=@"多线程";

    UIViewController *memoryDemoVC = [[MemoryDemoViewController alloc] init];
    UIViewController *memoryDemoVCNavigationController = [[UINavigationController alloc]
            initWithRootViewController:memoryDemoVC];
    [memoryDemoVC.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [memoryDemoVC.view setBackgroundColor:[UIColor whiteColor]];
    memoryDemoVC.title=@"内存";

    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.tabBar.tintColor = [UIColor whiteColor];
    [tabBarController setViewControllers:@[mainNavigationController, multithreadingNavigationController,memoryDemoVCNavigationController]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - UISceneSession lifecycle

//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
