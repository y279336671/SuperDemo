//
// Created by admin on 2021/3/8.
// Copyright (c) 2021 yanghe. All rights reserved.
//

#import "CustomButton.h"


@implementation CustomButton
- (nullable UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"hitTest");
    NSLog(@"point = %@", NSStringFromCGPoint(point));
    NSLog(@"event = %@", event);
    return [super hitTest:point withEvent:event];

}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"pointInside");
    NSLog(@"point = %@", NSStringFromCGPoint(point));
    NSLog(@"event = %@", event);
    return [super pointInside:point withEvent:event];
}
// 如果所在uiviewcontroller 实现了这个方法 那么不会调用
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesEnded");
    NSLog(@"touches = %@", touches);
    NSLog(@"event = %@", event);
    [super touchesEnded:touches withEvent:event];

}


@end