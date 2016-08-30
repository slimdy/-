//
//  LFRootViewControllerTool.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/10.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFRootViewControllerTool.h"
#import "LFTabBarController.h"
#import "LFNewFeatureCollectionViewController.h"
#define LastVersionKey @"lastVersion"
@implementation LFRootViewControllerTool
+(void)chooseRootViewControllerWithWindow:(UIWindow *)window{
    //当前软件最新版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //存储的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:LastVersionKey];
    //如果最新的版本号等于自身存储的版本号，则正面 目前是最新版，不用展示新特性
    if ([currentVersion isEqualToString:lastVersion]) {
        //将自己的tabBarController 成为根控制器  TabBarController控制器以创建就会加载view 也就是说ViewDidLoad方法会率先执行
        window.rootViewController = [[LFTabBarController alloc]init];
    }else{
        //展示新特性
        window.rootViewController = [[LFNewFeatureCollectionViewController alloc]init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:LastVersionKey];
    }

}
@end
