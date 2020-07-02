//
// Created by yanghe on 2020/7/1.
// Copyright (c) 2020 yanghe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject {

@public
    NSString *publicString;//@public公开的，可以被在任何地方访问。

@protected
    NSString *protectedString;//@protected是受保护的，只能在本类及其子类中访问，在{}声明的变量默认是@protect

@private
    NSString *privateString;//@private是私有的，只能在本类访问
}

// readonly关键字就不会自动生成setter方法，我们就不能使用 . 语法去赋值。此时我们有两种方式可以在内部使属性可读写：
// 1.我们可以在类的扩展中将属性再次设置成readwrite。
// 2.手动添加setter方法。
// 3.在外部可以通过kvc修改属性，如果禁止这种方式需要重写+(BOOL)accessInstanceVariablesDirectly 函数并返回NO,但是此时setValue一个readonly的方法就会崩溃,我们重写setValue方法过滤掉readonly的属性。

//  回炉KVC的访问流程？？？？？？？？？？？？？？？
//  KVC不需要访问setter和getter方法


@property(nonatomic, copy, readonly) NSString *name;  // @property它将自动创建一个以下划线开头的实例变量
//copy 和  strong 的区别？？？？？？？？？？？？？




@property(nonatomic, assign) NSInteger age;

//assign能否修饰对象类型？为什么？？？？？？？？？？？？？？？？、



- (instancetype)initWithName:(NSString *)name;

@end