//
//  LFTabBar.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/6.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFTabBar.h"
#import "LFTabBarButton.h"
@interface LFTabBar()
/**
 *  tabbar 中间的加号按钮
 */
@property (nonatomic,weak)UIButton *plusBtn;
/**
 *  所有按钮的数组
 */
@property (nonatomic,strong)NSMutableArray *buttons;
/**
 *  当前选中按钮
 */
@property (nonatomic,weak)UIButton *selectedBnt;
@end
@implementation LFTabBar
/**
 *  懒加载所有按钮数组
 *
 *  @return
 */
-(NSMutableArray *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
/**
 *  重写 所有tabbaritem 属性 数组的set方法
 *
 *  @param items
 */
-(void)setItems:(NSArray *)items{
    _items = items;
    //循环所有item 将每一个item 赋给button
    for (UITabBarItem *item in _items) {
        //创建自定义tabbarbutton
        LFTabBarButton * btn = [LFTabBarButton buttonWithType:UIButtonTypeCustom];
        btn.item = item;
        //将数组的数量当作button的tag
        btn.tag = self.buttons.count;
        //将每一个btn绑定点击方法
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        //将第一个按钮 设置成首页
        if (btn.tag == 0) {
            [self btnClick:btn];
        }
        //添加按钮到自定义tabbar
        [self addSubview:btn];
        //添加按钮到数组
        [self.buttons addObject:btn];
    }
}
/**
 *  点击btn 触发
 *
 *  @param btn 
 */
-(void)btnClick:(UIButton *)btn{
    self.selectedBnt.selected = NO;
    btn.selected = YES;
    self.selectedBnt = btn;
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickBtn:)]) {
        [self.delegate tabBar:self didClickBtn:btn.tag];
    }
}
/**
 *  懒加载中间的加号按钮
 *  因为控件的属性是weak 弱引用，如果直接用_plusBnt 的话 会为nil 所以 用临时变量btn 先创建，再将之赋值给_plusBtn
 *  @return button
 */

-(UIButton *)plusBtn{
    if (_plusBtn == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        //sizeToFit:默认会根据按钮的背景图片或者image和文字计算出按钮的最合适的尺寸
        [btn sizeToFit];
        _plusBtn = btn;
        //这句代码和关键，试讲弱引用的_plusBtn 用self.subView 强引用数组 强引用了，所以他不会随着方法结束而销毁
        [self addSubview:_plusBtn];
       
    }
    return _plusBtn;
}
/**
 *  重新布局子控件
 *  self.items UITabBarItem模型，有多少个子控制器就有多少个UITabBarItem模型
 */
-(void)layoutSubviews{
    //父类方法不能忘
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    //self.items UITabBarItem模型的所组成的数组，有多少个子控制器就有多少个UITabBarItem模型
    CGFloat btnW = width/(self.items.count + 1);
    CGFloat btnH = height;
    NSInteger i = 0;
    for (UIView *item in self.buttons) {
        //因为UITabBarButton 是私有类  无法访问，所以用到反向映射
//        if ([item isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i==2) {
                i=3;
            }
            btnX = i * btnW;
            item.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
//        }
    }
    //设置中心点即可
    self.plusBtn.center = CGPointMake(width * 0.5, height * 0.5);

    
   
}

@end
