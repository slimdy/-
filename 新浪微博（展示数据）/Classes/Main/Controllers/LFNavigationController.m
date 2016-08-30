//
//  LFNavigationController.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/8.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFNavigationController.h"

@interface LFNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic,strong) id gestureDelegate;
@end

@implementation LFNavigationController
/**
 *  第一次用这个类的时候触发
 *  初始化类
 *  如果通过模型设置控件的文字颜色，只能通过文本属性（富文本：颜色，字体，空心，阴影，图文混排）
 *  在ios7之后，默认会把UITabBar上面的按钮图片渲染成蓝色
 */
+ (void)initialize{
   
    //获取 所有UITabBarButtonItem的外观，因为ios7 以后会默认将文字图片渲染成蓝色。 获得外观时要注意 如果只用appearance方法会获得全局的外观，如果只想设置局部外观则要用appearanceWhenContainedIn 这个方法
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];

    //因为UITabBarItem 是数据模型，要设置模型的颜色 只能通过设置文本属性（也就是富文本）
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    //在这里存储导航控制器手势返回的代理
    self.gestureDelegate = self.interactivePopGestureRecognizer.delegate;
    
}
/**
 *  重写导航控制器的push方法
 *
 *  @param viewController 要push的控制器
 *  @param animated       动画
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //在pushVC之前self.viewControllers.count 如果是0 则证明将要push的控制器是第一个控制器，也就是根控制器
    //如果是不是0的话 则说明是后面的控制器，如果是后面的控制器则需要隐藏tabbar，并且设置统一的左右navigationbuttonItem
    //注意：是在push 控制器之前进行的操作
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithNormalImage:[UIImage imageNamed:@"navigationbar_back"] SelectedImage:[UIImage OriginalImageWith:@"navigationbar_back_highlighted"] target:self Sel:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = leftItem;
        
        UIBarButtonItem *rightItem = [UIBarButtonItem barButtonItemWithNormalImage:[UIImage imageNamed:@"navigationbar_more"] SelectedImage:[UIImage OriginalImageWith:@"navigationbar_more_highlighted"] target:self Sel:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = rightItem;
    }
    
    [super pushViewController:viewController animated:YES];
}
-(void)goBack{
    [self popViewControllerAnimated:YES];
}
-(void)more{
    [self popToRootViewControllerAnimated:YES];
}
#pragma mark --UINavigationController的代理--在控制器将要显示时触发
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //删除tabbar 系统自带的uitabbarbutton
    UITabBarController *tabBarVC = (UITabBarController *)LFKeyWindow.rootViewController;
    for (UIView *view in tabBarVC.tabBar.subviews) {
        //反向映射 找类，因为UITabbarButton 是私有类，无法通过 iskindofclass 来查
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }
}
#pragma mark --UINavigationController的代理--在控制器已经显示时触发
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //如果传过来的控制器是导航控制器的第一个，也就是根控制器时 我们需要将他的滑动返回手势的代理恢复
    if (viewController == self.viewControllers[0]) {
       
        self.interactivePopGestureRecognizer.delegate = self.gestureDelegate;
    }else{
        
        //因为我们将系统自动返回的按钮覆盖了，本来系统自带的滑动返回效果也就消失了，问题的根源是导航控制器有一个返回手势，它的代理清空就好了，但是，如果光清空代理，会出现其他问题，所以在界面回到根控制器的时候，将代理返回
        
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
