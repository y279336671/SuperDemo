//
//  ManualKVO.m
//  SuperDemo
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import "ManualKVO.h"

@implementation ManualKVO

+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if([key isEqualToString:@"name"]){
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];

}

-(void)setName:(NSString *)name {
    [self willChangeValueForKey:@"name"];
    _name = name;
    [self didChangeValueForKey:@"name"];
}
@end
