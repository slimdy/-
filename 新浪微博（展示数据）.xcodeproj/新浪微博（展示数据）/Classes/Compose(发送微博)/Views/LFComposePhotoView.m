//
//  LFComposePhotoView.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/16.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFComposePhotoView.h"

@implementation LFComposePhotoView

-(void)setImage:(UIImage *)image{
    _image = image;
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = image;
    [self addSubview:imageView];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger cols = 3;
    CGFloat margin = 10;
    CGFloat imageWH =(self.width - (cols - 1)*margin)/cols;
    CGFloat x = 0 ;
    CGFloat y = 0 ;
    CGFloat row = 0;
    CGFloat col = 0;
    for (NSInteger i = 0 ; i < self.subviews.count; i++) {
        UIImageView *imagev = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = col * (imageWH + margin);
        y = row * (imageWH + margin);
        imagev.frame = CGRectMake(x, y, imageWH, imageWH);
    }
}
@end
