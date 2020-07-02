//
// Created by yanghe on 2020/7/1.
// Copyright (c) 2020 yanghe. All rights reserved.
//

#import "Person.h"
@interface Person()

@end

@implementation Person

// @synthesize语句只能被用在 @implementation 代码段中
// @synthesize的作用就是让编译器为你自动生成setter与getter方法
// @synthesize还有一个作用，可以指定与属性对应的实例变量，例如@synthesize name = xxx ,默认是  @synthesize name = _name
// 使用 @dynamic 来阻止 @synthesize 自动生成新的 setter/getter 覆盖。
// @synthesize 和 ARC 无关。
// 一般情况下无需对属性添加 @synthesize ，但一些特殊情形不会自动合成setter和getter方法,并且不会检测和自动帮我们生成成员变量,则需要我们自己添加成员变量:
// 1>同时重写了 setter 和 getter 时;
// 2>重写了只读属性的 getter 时;
// 3>使用了 @dynamic 时;
// 4>在 @protocol 中定义的所有属性;
// 5>在 category 中定义的所有属性;
// 6>重写的属性, 当你在子类中重写了父类中的属性，你必须使用 @synthesize 来手动合成ivar。

- (instancetype)initWithName:(NSString *)name{
    if (self = [super init]) {
        _name = name;
    }

    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToPerson:other];
}

-(BOOL)isEqualToPerson:(Person *)person{
    if([self.name isEqualToString:person.name]){
        return YES;
    } else{
        return NO;
    }
}

- (NSUInteger)hash {
    return [self.name hash];
}

// == 和 isEqual :
// == 如果是基本类型就对比值，如果是对象就对比两个对象的地址。
// isEqual对比两个对象，isEqual系统默认的实现也是对比两个对象的指针,但是isEqualString确重写了isEqual了，这样可以判断字符串的值是否相等。
// 如果我们要以某一个字段为标准判断两个对象是否相等，就需要重写isEqual方法，并且重写hash方法。重写hash是由于对象有可能被添加到NSSet中，NSSet内部使用hash值来作为key存储,
// 使用OC自定义的类实例作为NSDictionary的key的话，需要实现NSCoping协议

// hash和isEqual的关系
// hash方法会在对象被添加到NSSet中的时候调用
// hash方法会在对象被用作NSDictionary的key的时候调用
// 如果两个对象相等，那么他们hash值一定相等
// 如果两个对象hash值相等(hash算法不完美导致)，他们不一定相等，还要继续通过isEqual进行判断是否真的相等


@end