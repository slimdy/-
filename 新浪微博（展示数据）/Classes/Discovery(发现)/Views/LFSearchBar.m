//
//  LFSearchBar.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/9.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFSearchBar.h"
@interface LFSearchBar()
@end
@implementation LFSearchBar
/**
 *  重写自定义搜索框的initWithFrame方法
 *
 *  @param frame <#frame description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.background = [UIImage imageWithStretchableImage:[UIImage imageNamed:@"searchbar_textfield_background"]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        
        imageView.contentMode = UIViewContentModeCenter;
        //看起来更宽松一些
        imageView.width +=10;
        self.leftView = imageView;
        //设置leftView 一定要打开这个模式
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end
