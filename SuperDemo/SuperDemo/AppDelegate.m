//
//  AppDelegate.m
//  SuperDemo
//
//  Created by yanghe on 2020/6/21.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
//#import "TaggedPointerViewController.h"

//#import "ExposureViewController.h"
//#import <Aspects.h>
//#import <Aspects/Aspects.h>

#import "AutoKVO/AutoKVO.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#if DEBUG
   // iOS
   [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];

   // 同时还支持 tvOS 和 MacOS，配置时只需要在 /Applications/InjectionIII.app/Contents/Resources/ 目录下找到对应的 bundle 文件,替换路径即可
#endif
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}




@end
