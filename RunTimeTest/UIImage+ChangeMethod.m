//
//  UIImage+ChangeMethod.m
//  RunTimeTest
//
//  Created by 周君 on 16/10/28.
//  Copyright © 2016年 周君. All rights reserved.
//

#import "UIImage+ChangeMethod.h"
#import <objc/message.h>

@implementation UIImage (ChangeMethod)

// 把类加载进内存的时候调用,只会调用一次
+ (void)load
{
    // self -> UIImage
    // 获取imageNamed
    // 获取哪个类的方法
    // SEL:获取哪个方法
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    // 获取zj_imageNamed
    Method zj_imageNamedMethod = class_getClassMethod(self, @selector(zj_imageNamed:));
    
    // 交互方法:runtime
    method_exchangeImplementations(imageNamedMethod, zj_imageNamedMethod);
    // 调用imageNamed => zj_imageNamedMethod
    // 调用zj_imageNamedMethod => imageNamed
}

// 1.加载图片
// 2.判断是否加载成功
+ (UIImage *)zj_imageNamed:(NSString *)name
{
    // 图片这里实际执行的就是系统原来的方法，因为方法被交换
    UIImage *image = [UIImage zj_imageNamed:name];
    
    if (image) {
        NSLog(@"加载成功");
    } else {
        NSLog(@"加载失败");
    }
    
    return image;
}
@end
