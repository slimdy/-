//
//  LFTabBar.h
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/6.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LFTabBar;
@protocol LFTabBarDelegate <NSObject>
/**
 *  点击自定义tabbar上的按钮的协议方法
 *
 *  @param tabBar
 *  @param index  点击的那个按钮
 */
-(void)tabBar:(LFTabBar *)tabBar didClickBtn:(NSInteger)index;
@end
@interface LFTabBar : UIView
/**
 *  所有uitabbaritem 属性的数组
 */
@property (nonatomic,strong)NSArray *items;
/**
 *  代理
 */
@property (nonatomic,weak)id<LFTabBarDelegate>  delegate;
@end
