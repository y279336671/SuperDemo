//
//  AppDelegate.m
//  SuperDemo
//
//  Created by yanghe on 2020/6/21.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import "AppDelegate.h"
#import "TestOC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
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
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
