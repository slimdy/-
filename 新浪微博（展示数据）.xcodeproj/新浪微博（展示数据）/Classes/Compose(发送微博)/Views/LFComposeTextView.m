//
//  LFComposeTextView.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/16.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFComposeTextView.h"

@interface LFComposeTextView()
@property (nonatomic,weak)UILabel *placeHolder;
@end
@implementation LFComposeTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placeHolder = [[UILabel alloc]init];
        placeHolder.text = @"分享新鲜事...";
        placeHolder.textColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:18];
        placeHolder.font = self.font;
        [placeHolder sizeToFit];
        _placeHolder = placeHolder;
        [self addSubview:placeHolder];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.placeHolder.x = 5;
    self.placeHolder.y = 8;
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeHolder.font = font;
}
-(void)setIshidden:(BOOL)ishidden{
    self.placeHolder.hidden = ishidden;
}
@end
