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
//多次添加会进入多次
//多次删除为什么会crash
//如果不删除会怎么样
//添加了观察者，但未实现 observeValueForKeyPath:ofObject:change:context: 方法，导致崩溃。
//添加或者移除时 keypath == nil，导致崩溃。

//------------------------------------------------
//NSNotification 和 KVO 防止崩溃的大致原理相同
//1. 先hook住add 和 remove等方法，替换成我们自己的方法。
//2. 然后在我们自己的方法中添加字典，记录是哪个对象添加了具体哪个通知或者kvo
//3. 在remove的时候在字典中进行判断，是否已经remove了避免过度remove
//4. hook住的dealloc当对应的对象释放的时候，可以在字典中查找未正常remove的通知或者kvo。注意也要调用一下原来的dealloc方法
//------------------------------------------------
@implementation ManualKVO
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    self.person = [[Person alloc] init]; //如果  person是局部变量 iOS10 之前会崩溃
    self.person.name=@"yyy";
    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
//    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.person.name=@"hhh";
//    [self.person setValue:@"hhhh" forKey:@"_name"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context {
    id new = change[NSKeyValueChangeNewKey];
    id old = change[NSKeyValueChangeOldKey];
    NSLog(@"new = %@", new);
    NSLog(@"old = %@", old);
}

-(void)dealloc{
    [self.person removeObserver:self forKeyPath:@"name"];
//    [self.person removeObserver:self forKeyPath:@"name"];
    NSLog(@"%s", sel_getName(_cmd));
}
@end
