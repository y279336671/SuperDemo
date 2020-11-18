//
//  CategoryWeakProperty.m
//  SuperDemo
//
//  Created by admin on 2020/11/16.
//  Copyright © 2020 yanghe. All rights reserved.
//

#import <objc/runtime.h>
#import "CategoryWeakProperty.h"
//1. https://blog.csdn.net/yan_1564335/article/details/53996538    分类中的weak属性强引用一个对象A，weak属性被释放后会调用A的dealloc，delloc中回调给分类进行对属性的置nil处理
@interface CategoryWeakProperty ()
//@property (nonatomic, weak)id weakObject;
@end
@implementation CategoryWeakProperty
//-(void)setWeakObject:(id)weakObject {
//    objc_getAssociatedObject
//    objc_setAssociatedObject(weakObject, <#const void * key#>, <#id value#>, OBJC_ASSOCIATION_RETAIN);
//}
//-(id)getWeakObject{
//    return objc_getAssociatedObject(<#id object#>, <#const void * key#>)
//}
@end
