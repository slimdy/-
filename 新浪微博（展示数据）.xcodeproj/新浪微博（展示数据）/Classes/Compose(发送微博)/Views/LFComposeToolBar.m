//
//  LFComposeToolBar.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/16.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFComposeToolBar.h"

@implementation LFComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setAllChildViews];
    }
    return self;
}
-(void)setAllChildViews{
    [self setOneBtnWithTitle:nil NormalImage:[UIImage imageNamed:@"compose_toolbar_picture"] HightLightImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:) tag:0];
    [self setOneBtnWithTitle:nil NormalImage:[UIImage imageNamed:@"compose_mentionbutton_background"] HightLightImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] target:self action:@selector(btnClick:) tag:1];
    [self setOneBtnWithTitle:nil NormalImage:[UIImage imageNamed:@"compose_trendbutton_background"] HightLightImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"] target:self action:@selector(btnClick:) tag:2];
    [self setOneBtnWithTitle:nil NormalImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] HightLightImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] target:self action:@selector(btnClick:) tag:3];
    [self setOneBtnWithTitle:nil NormalImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] HightLightImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] target:self action:@selector(btnClick:) tag:4];
    
}
-(void)setOneBtnWithTitle:(NSString*)title NormalImage:(UIImage *)NormalImage HightLightImage:(UIImage *)hightLightImage target:(id)object action:(SEL)action tag:(NSInteger)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:NormalImage forState:UIControlStateNormal];
    [btn setImage:hightLightImage forState:UIControlStateHighlighted];
    btn.imageView.contentMode = UIViewContentModeCenter;
    [btn addTarget:object action:action forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self addSubview:btn];
}
-(void)btnClick:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickBtn:)]) {
        [self.delegate composeToolBar:self didClickBtn:btn];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat btnH = self.height;
    CGFloat btnW = self.width/self.subviews.count;
    CGFloat x = 0;
    CGFloat y = 0;
    for (NSInteger i = 0; i< self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        x= i * btnW;
        btn.frame = CGRectMake(x, y, btnW, btnH);
    }
    
}
@end
