//
//  NSObject+AddAttribute.m
//  RunTimeTest
//
//  Created by 周君 on 16/10/28.
//  Copyright © 2016年 周君. All rights reserved.
//

#import "NSObject+AddAttribute.h"
#import <objc/message.h>

@implementation NSObject (AddAttribute)
// 动态添加属性:什么时候需要动态添加属性

// 开发场景
// 给系统的类添加属性的时候,可以使用runtime动态添加属性方法

// 本质:动态添加属性,就是让某个属性与对象产生关联

// 需求:让一个NSObject类 保存一个字符串

// runtime一般都是针对系统的类

// 通过这两个方法进行赋值
- (void)setName:(NSString *)name
{
    // 让这个字符串与当前对象产生联系
    
    //    _name = name;
    // object:给哪个对象添加属性
    // key:属性名称
    // value:属性值
    // policy:保存策略
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name
{
    return objc_getAssociatedObject(self, @"name");
}

@end
