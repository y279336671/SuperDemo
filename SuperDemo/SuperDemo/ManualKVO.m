//
//  ManualKVO.m
//  SuperDemo
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import "ManualKVO.h"
#import "Person.h"
@interface ManualKVO ()
@property(nonatomic, strong)Person *person;
@end
//多次添加 为什么会进入多次
//多次删除为什么会crash  如何处理
//如果不删除会怎么样 如何处理
@implementation ManualKVO
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    self.person = [[Person alloc] init];
    self.person.name=@"yyy";
    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
//    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.person.name=@"hhh";
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
//    id new = change[NSKeyValueChangeNewKey];
//    id old = change[NSKeyValueChangeOldKey];
//    NSLog(@"new = %@", new);
//    NSLog(@"old = %@", old);
}

-(void)dealloc{
    [self.person removeObserver:self forKeyPath:@"name"];
    [self.person removeObserver:self forKeyPath:@"name"];
    NSLog(@"%s", sel_getName(_cmd));
}
@end
