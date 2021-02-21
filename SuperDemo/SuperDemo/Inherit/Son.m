//
// Created by yanghe on 2021/2/21.
// Copyright (c) 2021 yanghe. All rights reserved.
//

#import "Son.h"
#import "Tools.h"


@implementation Son
+ (void)load {
    [Tools zb_betterMethodSwizzlingWithClass:[self class] oriSEL:@selector(testExchangeA) swizzledSEL:@selector(testExchangeB)];
}

-(void)testExchangeA{
    NSLog(@"testExchangA son");
}
//-(void)testExchangeB{
//    NSLog(@"testExchangeB son");
//}
@end