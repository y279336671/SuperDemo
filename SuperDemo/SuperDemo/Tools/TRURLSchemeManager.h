//
//  TRWebViewManager.h
//  TrafficRecords
//
//  Created by yanghe on 15/8/4.
//  Copyright (c) 2015年 AutoHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRURLSchemeManager : NSObject
-(void)openScheme:(NSString *)url;
+ (instancetype)globalURLSchemeManager;

@end
