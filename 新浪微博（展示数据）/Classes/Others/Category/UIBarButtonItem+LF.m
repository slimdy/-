//
//  UIBarButtonItem+LF.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/8.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "UIBarButtonItem+LF.h"

@implementation UIBarButtonItem (LF)
/*
*  用来生成宇哥UIBarButtonItem 的简便方法
*
*  @param image         正常图片
*  @param selectedImage 选中时的图片
*  @param target        谁来监听
*  @param action        监听的函数
*  @param events        事件
*
*  @return
*/
+(instancetype)barButtonItemWithNormalImage:(UIImage *)image SelectedImage:(UIImage *)selectedImage target:(id)target Sel:(SEL)action forControlEvents:(UIControlEvents)events{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:events];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
