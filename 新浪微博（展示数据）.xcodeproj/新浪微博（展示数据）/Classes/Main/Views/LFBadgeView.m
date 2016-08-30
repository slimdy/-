//
//  LFBadgeView.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/11.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFBadgeView.h"

@implementation LFBadgeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self sizeToFit];
    }
    return self;
}
-(void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    //如果badgeValue 没有值或者值是0 则不显示
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    //计算 badgeValue 值得文字大小
    CGSize size = [badgeValue sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11]}];
    //如果badgeValue 大于 本身sizetofit 计算出来的值 则换图
    if (size.width > self.width) {//如果文字的宽度大于自身的宽度
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
}
@end
