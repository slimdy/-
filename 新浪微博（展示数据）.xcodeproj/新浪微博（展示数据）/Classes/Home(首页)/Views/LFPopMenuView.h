//
//  LFPopMenuView.h
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/8.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFPopMenuView : UIImageView
/**
 *  显示内容的View ，将菜单控制器的View放置在里面
 */
@property (nonatomic,weak)UIView *contentView;
/**
 *  在区域内显示菜单View
 *
 *  @param rect
 *
 *  @return
 */
+(instancetype)showInRect:(CGRect)rect;
/**
 *  移除菜单View
 */
+(void)hide;
@end
