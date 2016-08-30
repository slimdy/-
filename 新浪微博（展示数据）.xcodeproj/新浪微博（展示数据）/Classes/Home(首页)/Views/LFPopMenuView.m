//
//  LFPopMenuView.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/8.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFPopMenuView.h"

@implementation LFPopMenuView
/**
 *  显示菜单View 将它展示在window的最前面
 *
 *  @param rect 展示区域
 *
 *  @return
 */
+(instancetype)showInRect:(CGRect)rect{
    LFPopMenuView *popView = [[LFPopMenuView alloc]initWithFrame:rect];
    //因为是imageView 所以要设置用户交互
    popView.userInteractionEnabled = YES;
    //因为需要气泡是的背景图片，这也是用imageView 来做底层View的原因
    popView.image = [UIImage imageWithStretchableImage:[UIImage imageNamed:@"popover_background"]];
    //将它添加到window的最外层
    [LFKeyWindow addSubview:popView];
    return popView;
}
/**
 *  移除菜单View
 */
+(void)hide{
    for (UIView *popView in LFKeyWindow.subviews) {
        if ([popView isKindOfClass:self]) {
            [popView removeFromSuperview];
        }
    }
}
/**
 *  重写contentView属性的set方法
 *
 *  @param contentView
 */
-(void)setContentView:(UIView *)contentView{
    
    //将之前的显示菜单View 删除
    [_contentView removeFromSuperview];
    //把最新的菜单View 放入
   _contentView = contentView;
    //清除背景颜色
    _contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentView];
}
/**
 *  重新布局子控件
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //这里有个注意点是：y为什么等于9 ，是因为 这个背景图片，是气泡型的有个小尖，如果是5的话，tableview会现处在背景图外面
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat y = 9;
    CGFloat height = self.height-y-margin;
    CGFloat width = self.width -2*margin;
    self.contentView.frame = CGRectMake(x, y, width, height);
}
@end
