//
//  LFHomeTitleView.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/8.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFHomeTitleView.h"

@interface LFHomeTitleView()
@end
@implementation LFHomeTitleView
/**
 *  初始化头部TitleView
 *
 *  @param frame <#frame description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
       
    }
    return self;
}
/**
 *  重新布局button里面的imageView和label
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.currentImage == nil) {
        return;
    }
    // 将titleLabel 和 imageView 调换位置
    CGFloat x = 0;
    self.titleLabel.x = x;
    self.imageView.x = x+self.titleLabel.width;
    
//    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);

    
}
/**
 *  重写setTitle方法 ，让button 自适应图片和位子
 *
 *  @param title <#title description#>
 *  @param state <#state description#>
 */
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end
