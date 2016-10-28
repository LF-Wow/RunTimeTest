//
//  ViewController.m
//  RunTimeTest
//
//  Created by 周君 on 16/10/22.
//  Copyright © 2016年 周君. All rights reserved.
//

/**
 * RunTime 简称为运行时。OC就是一种运行时机制，就是再运行的时候执行的一种机制，其中最主要的是消息机制
 * 相对来说C语言是在编译的时候就知道要调用哪个函数,因为C语言如果只声明函数不去实现，在编译的时候就会报错
 * 但是对于OC的函数来说，编译时候，你可以只声明但是不去实现，但是在运行的时候就会报错。因为在运行的时候会调用这个函数。
 *
 * RunTime的几个作用：
 * 1、消息机制：OC中调用方法的本质实质就是让对象发送消息objc_msgSend
 * 2、交换方法（开发中常用的方法）：让两个方法交换，即在调用两个方法的时候互相执行对方的方法
 * 3、动态的添加方法
 * 4、给分类添加属性
 * 5、字典转模型、封装数据库、自动解档和归档
 */

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>
#import "NSObject+AddAttribute.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self msgSend];
    
//    [self addMethod];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){100, 100, 100, 100}];
//    [self.view addSubview:imageView];
//    imageView.image = [UIImage imageNamed:@"表情.jpg"];
    
    Person *p = [[Person alloc] init];
    p.name = @"zhangsan";
    NSLog(@"%@", p.name);
}

- (void)msgSend
{
    /**  消息机制*/
    
    // 类方法本质:类对象调用[NSObject class]
    // id:谁发送消息
    // SEL:发送什么消息
    // ((NSObject *(*)(id, SEL))(void *)objc_msgSend)([NSObject class], @selector(alloc));
    
//    开发中使用场景:需要用到runtime,消息机制
//    1.装逼
//    2.不得不用runtime消息机制,可以帮我调用私有方法.
    
    //    Person *p = [Person alloc];
    Person *p = objc_msgSend(objc_getClass("Person"), sel_registerName("alloc"));
    //    p = [p init];
    
    p = objc_msgSend(p, sel_registerName("init"));
    
    // 调用eat
    [p eat];
    
    objc_msgSend(p, @selector(eat));
    //    objc_msgSend(p, @selector(run:),20);
    
    /** 使用消息机制的一些问题*/
    // xcode6之前,苹果运行使用objc_msgSend.而且有参数提示
    // xcode6苹果不推荐我们使用runtime
    
    // 解决消息机制方法提示步骤
    // 查找build setting -> 搜索msg
    // 最终生成消息机制,编译器做的事情
    // 最终代码,需要把当前代码重新编译,用xcode编译器,clang
    // clang -rewrite-objc main.m 查看最终生成代码
}

- (void)addMethod
{
    /*
     开发中不太常用，但是面试的时候用
     Runtime(动态添加方法):OC都是懒加载机制,只要一个方法实现了,就会马上添加到方法列表中.
     app:免费版,收费版
     QQ,微博,直播等等应用,都有会员机制
     
     美团有个面试题?有没有使用过performSelector,什么时候使用?动态添加方法的时候使用过?怎么动态添加方法?用runtime?为什么要动态添加方法?
     */
    //什么时候动态添加方法： 如果有些方法不经常用，可以先不去实现，使用动态添加方法的方法去调用
    Person *p = [[Person alloc] init];
    [p performSelector:@selector(run:) withObject:@10];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
