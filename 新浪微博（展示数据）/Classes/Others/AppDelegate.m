//
//  AppDelegate.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/6.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "AppDelegate.h"
#import "LFTabBarController.h"
#import "LFNewFeatureCollectionViewController.h"
#define LastVersionKey @"lastVersion"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //因为是纯代码写的，所以自己创建window
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    

    //当前软件最新版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //存储的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:LastVersionKey];
    //如果最新的版本号等于自身存储的版本号，则正面 目前是最新版，不用展示新特性
    if ([currentVersion isEqualToString:lastVersion]) {
        //将自己的tabBarController 成为根控制器  TabBarController控制器以创建就会加载view 也就是说ViewDidLoad方法会率先执行
          self.window.rootViewController = [[LFTabBarController alloc]init];
    }else{
        //展示新特性
        self.window.rootViewController = [[LFNewFeatureCollectionViewController alloc]init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:LastVersionKey];
    }
    
   
    //让窗口可见
    [self.window makeKeyAndVisible];
    
    //上面这个方法实际上底层是这样的
//    application.keyWindow = self.window;
//    self.window.hidden = NO;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
