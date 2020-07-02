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

//  KVC查找顺序Set<key> -> accessInstanceVariablesDirectly==yes -> _key -> _isKey -> key -> isKey  也就是说即使没有setter方法，也能修改属性值
//                                                      |->no -> setValue：forUndefinedKey：

// copy 和 strong 的区别
// NSString、NSArray、NSDictionary 经常使用copy关键字,为避免他们的可变子类，比如NSMutableString NSMutableArray、NSMutableDictionary在赋值的时候，引起不必要的改变。而copy会复制一份新内存指向可变对象。Strong只会增加引用计数器
@property(nonatomic, copy, readonly) NSString *name;  // @property它将自动创建一个以下划线开头的实例变量


// assign一般用于修饰基本数据类型，原因是基本数据类型会被分配到栈上，栈上的内存是系统自动管理，不会产生野指针，assign也可以修饰对象类型，但是会产生野指针。而weak修饰的对象在释放时会被指向nil，就不会产生野指针。
@property(nonatomic, assign) NSInteger age;

- (instancetype)initWithName:(NSString *)name;

@end