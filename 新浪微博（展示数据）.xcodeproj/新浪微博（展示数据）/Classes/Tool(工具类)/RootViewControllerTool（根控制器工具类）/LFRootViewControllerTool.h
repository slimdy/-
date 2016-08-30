//
//  LFRootViewControllerTool.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/10.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFRootViewControllerTool : NSObject
/**
 *  选择新特性还是首页为根控制器
 *
 *  @param window 当前window
 */
+(void)chooseRootViewControllerWithWindow:(UIWindow *)window;
@end
