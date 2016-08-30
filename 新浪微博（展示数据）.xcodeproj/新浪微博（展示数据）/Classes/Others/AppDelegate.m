//
//  AppDelegate.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/6.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "AppDelegate.h"
#import "LFRootViewControllerTool.h"
#import "LFOAuthViewController.h"
#import "LFAccountTool.h"
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate ()
@property (nonatomic,strong)AVAudioPlayer *player;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 注册通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    
    // 设置音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 单独播放一个后台程序
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    
    [session setActive:YES error:nil];
    
    //因为是纯代码写的，所以自己创建window
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    
    if ([LFAccountTool getAccount]) {//如果有账户 则选择控制器到底是新特性 还是 首页
        [LFRootViewControllerTool chooseRootViewControllerWithWindow:self.window];
    }else{//如果没有账户，先去sina授权OAuth
        //创建OAuth2的展示控制器
        //设置为根控制器
        self.window.rootViewController = [[LFOAuthViewController alloc]init];
    }
    
    
    //让窗口可见
    [self.window makeKeyAndVisible];
    
    //上面这个方法实际上底层是这样的
//    application.keyWindow = self.window;
//    self.window.hidden = NO;
    
    return YES;
}
-(void)chooseRootViewController{
    }
- (void)applicationWillResignActive:(UIApplication *)application {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    // 无限播放
    player.numberOfLoops = -1;
    
    [player play];
    
    _player = player;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 开启一个后台任务,时间不确定，优先级比较低，假如系统要关闭应用，首先就考虑
  UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
      [application endBackgroundTask:ID];
  }];
    // 如何提高后台任务的优先级，欺骗苹果，我们是后台播放程序
    
    // 但是苹果会检测你的程序当时有没有播放音乐，如果没有，有可能就干掉你
    
    // 微博：在程序即将失去焦点的时候播放静音音乐.
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
