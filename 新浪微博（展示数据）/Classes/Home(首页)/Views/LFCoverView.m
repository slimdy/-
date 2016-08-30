//
//  LFCoverView.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/8.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFCoverView.h"

@implementation LFCoverView

/**
 *  生成全屏蒙版
 *
 *  @return 
 */
+(instancetype)show{
    LFCoverView *coverView = [[LFCoverView alloc]initWithFrame:MainScreen.bounds];
    coverView.backgroundColor = [UIColor clearColor];
    [LFKeyWindow addSubview:coverView];
    return coverView;
}

/**
 *  点击屏幕取消蒙版
 *
 *  @param touches
 *  @param event
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(coverViewDIdClicKWith:)]) {
        [self.delegate coverViewDIdClicKWith:self];
    }
}
@end
