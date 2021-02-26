//
//  TRWebViewManager.m
//  TrafficRecords
//
//  Created by yanghe on 15/8/4.
//  Copyright (c) 2015年 AutoHome. All rights reserved.
//
#import "TRURLSchemeManager.h"
#import <UIKit/UIKit.h>

@interface TRURLSchemeManager ()
//@property(nonatomic, weak) UIView *currentWV;
//@property(nonatomic, strong) NSURL *currentUrl;
//@property(nonatomic, strong) NSDictionary *keyForVC;
@end

@implementation TRURLSchemeManager


+ (instancetype)globalURLSchemeManager {
    static id instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        // 读取服务器下发的白名单 key-value形式
//        self.keyForVC = [@{@"BlockViewController": @"BlockViewController", @"BlockSubViewController"
//                : @"BlockSubViewController"} mutableCopy];
    }
    return self;
}

//`优化前：wzsdk://login?source=home`
//`优化后：wzsdk://login/loginout?source=home`

-(void)openScheme:(NSString *)url{
    NSURL *tmpUrl = [NSURL URLWithString:url];
    NSString *host = tmpUrl.host;//login
    NSString *absoluteURL=tmpUrl.absoluteString;//wzsdk://login/loginout?source=home
    NSString *query = tmpUrl.query;//source=home
    NSString *path = tmpUrl.path;//loginout

    NSString *className = [self readClassNameFromWhiteList:host];//读取本地白名单，可通过服务器控制开关对应scheme
    Class aClass = NSClassFromString(className); //根据类名初始化对象

    //todo 给属性赋值
    //todo 调用方法并且传递参数，注意基础数据类型和对象类型的参数
    //todo 本地native调用scheme需要拿到返回值
    //todo 服务器调用拿到返回值
}

//读取本地白名单
-(NSString *)readClassNameFromWhiteList:(NSString *)key{
    // todo 这里还需要服务器动态下发白名单，暂时使用本地json测试
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"Schemes" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingFragmentsAllowed error:&error];
    return result[key]?result[key]:@"";
}

@end
