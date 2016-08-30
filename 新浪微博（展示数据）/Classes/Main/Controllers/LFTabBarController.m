//
//  LFTabBarController.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/6.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFTabBarController.h"
#import "LFTabBar.h"
#import "LFNavigationController.h"
#import "LFDiscoveryTableViewController.h"
#import "LFProfileTableViewController.h"
#import "LFHomeTableViewController.h"
#import "LFMessageTableViewController.h"
@interface LFTabBarController ()<LFTabBarDelegate>
@property (nonatomic,strong)NSMutableArray *items;
@end
/**
 *  总结：
 *     1. a.+(void)load 方法是在开启应用之前，系统会将所有的类放在内存中的时候调用，所以他最先被调用
 *        b.main 主函数，会在第二个被调用
 *        c.接下来会进入代理的didFinishLaunchingWithOptions方法
 *        d.initialize方法会在第一次使用这个类的时候调用
 *     2.main主函数会调用UIApplicationMain（）方法，这个方法有3个重要的步骤
 *        a.创建UIApplication对象
 *        b.创建AppDelegate对象，并成为UIApplication对象的代理
 *        c.开启mainloop，让程序一直跑起来
 *        d.加载info.plist文件，里面如果设置了main.storyboard 就回去加载main.storyboard
 *     3.main.storyboard在加载的时候会：
 *        a.初始化window
 *        b.加载storyboard里的内容，并且让它成为根控制器
 *        c.显示窗口
 *     4.UIViewController的View 是懒加载的 而UITabBarViewController的View 却不是 是以创建控制器就加载的
 *     5.在ios7之后，默认会把UITabBar上面的按钮图片渲染成蓝色。想要修改模型设置控件的文字颜色，
 *        只能通过文本属性（富文本：颜色，字体，空心，阴影，图文混排）。
 *        获得外观时要注意 如果只用appearance（只有遵守了UIAppearanceContainer协议的控件可以用这个方法，所有的uiview 都遵守了）方法会获得全局的外观，
         如果只想设置局部外观则要用appearanceWhenContainedIn 这个方法
 *      6.自定义tabBar 的设计：
           a.不能移除系统自带的tabbar，因为移除后，hidesBottomBarWhenPushed 隐藏tabbar 功能失效，所以需要把自定义tabbar添加到系统的tabbar 上面，并且在willappear 方法里删除系统的uitabbarbutton
 *         b.tabbar 按钮点击事件做成代理，在tabbarController 中实现
 *     7.自定义NavigationController 中要注意：
           a.如果需求定义的导航控制器的 左右navigationbaritem 是一样的话，在导航控制器中重写push方法
 *         b.导航控制器可以如果覆盖左边item时,会出现手势返回功能消失,需要清空interactivePopGestureRecognizer.delegate =nil  但是这样在导航控制器的根控制器中会出现无法跳转控制器的bug 所以要在根控制器push出来前 恢复interactivePopGestureRecognizer.delegate 找一个全局属性保存为好
 *     8.新特性页面，
           a.经常用UICollectionView 来做，做成流水性布局，每个cell 是一张展示图片，设置分页器即可。
           b.需要对比版本来决定是否向用户展示新特性页面，如果当前版本号不等于存储在偏好设置里的版本号，说明需要显示新特性。具体看新特性模块和appdelegate里面
 */
@implementation LFTabBarController
/**
 *  方法是在开启应用之前，系统会将所有的类放在内存中的时候调用，所以他最先被调用
 */
//+(void)load{

//}


/**
 *  tabbar 所有按钮的item 数组懒加载
 *
 *  @return <#return value description#>
 */
-(NSMutableArray *)items{
    if(!_items){
        _items = [NSMutableArray array];
    }
    return _items;
}

/**
 *  UITabBarController 会在创建的时候就调用这个方法，而UIViewController 的View 是等到懒加载的时候才会调用 
 *  所以这个方法可以初始化很多控件
 */
- (void)viewDidLoad {
    //父类方法中已经将self.tabBar 设置好了
    [super viewDidLoad];
    
    //这样设置不行，因为self.tabbar 是只读属性，只读属性用KVC 来赋值
    //    self.tabBar = [[LFTabBar alloc]init];
    
    //因为父类已经设置好 所以用KVC的方式将自己创建的TabBar 赋给self.tabBar
    //[self setValue:[[LFTabBar alloc]initWithFrame:self.tabBar.frame] forKeyPath:@"tabBar"];
    
    // KVC的底层就是用下面的这个通知机制做出来的
    //    objc_msgSend(self, @selector(setTabBar:),tabBar);
    
    //初始化所有的childViewController
    [self setAllChildViewControllers];
    //设置tabbar
    [self setTabBar];
}
-(void)setTabBar{
    //创建自定义tabbar
    LFTabBar * customTabBar = [[LFTabBar alloc]initWithFrame:self.tabBar.bounds];
    customTabBar.backgroundColor = [UIColor whiteColor];
    //将所有的item 赋值给自定义的items
    customTabBar.items = self.items;
    customTabBar.delegate = self;
//    [self setValue:customTabBar forKeyPath:@"tabBar"];
    //将自定义tabbar 天骄到系统的tabbar上
    [self.tabBar addSubview:customTabBar];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    //在页面加载的时候删除系统自带的tabbarbutton
    [super viewWillAppear:animated];
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }
}
/**
 *  初始化所有的childViewController
 */
-(void)setAllChildViewControllers{
   //设置首页
    LFHomeTableViewController *homeVC = [[LFHomeTableViewController alloc]init];
    [self setOneChildVieControllerWithNormalImage:[UIImage imageNamed:@"tabbar_home"] SelectedImage:[UIImage OriginalImageWith:@"tabbar_home_selected"] ViewController:homeVC Title:@"首页"];
    //设置消息
    LFMessageTableViewController *MessageVC = [[LFMessageTableViewController alloc]init];
    [self setOneChildVieControllerWithNormalImage:[UIImage imageNamed:@"tabbar_message_center"] SelectedImage:[UIImage OriginalImageWith:@"tabbar_message_center_selected"] ViewController:MessageVC Title:@"消息"];
    //设置发现
    LFDiscoveryTableViewController *discoveryVC = [[LFDiscoveryTableViewController alloc]init];
    [self setOneChildVieControllerWithNormalImage:[UIImage imageNamed:@"tabbar_discover"] SelectedImage:[UIImage OriginalImageWith:@"tabbar_discover_selected"] ViewController:discoveryVC Title:@"发现"];
    LFProfileTableViewController *profileVC = [[LFProfileTableViewController alloc]init];
    //设置我
    [self setOneChildVieControllerWithNormalImage:[UIImage imageNamed:@"tabbar_profile"] SelectedImage:[UIImage OriginalImageWith:@"tabbar_profile_selected"] ViewController:profileVC Title:@"我"];
    
    
}
/**
 *  设置单一个子控制器的TabBarItem(它是模型，里面包含了很多属性)
 *  tabBarItem:决定着tabBars上按钮的内容
 *
 *  @param NomalImage    正常状态下的图片
 *  @param selectedImage 被选择时的图片
 *  @param VC            要设置的控制器
 *  @param title         名称
 */
-(void)setOneChildVieControllerWithNormalImage:(UIImage *)NomalImage SelectedImage:(UIImage *)selectedImage ViewController:(UIViewController *)VC Title:(NSString *)title{
    VC.title = title;
    VC.tabBarItem.image = NomalImage;
    VC.tabBarItem.selectedImage = selectedImage;
    //将每一个控制器的tabbaritem属性放到一个数组中
    [self.items addObject:VC.tabBarItem];
    //创建自定义导航控制器
    LFNavigationController *NAV = [[LFNavigationController alloc]initWithRootViewController:VC];
    [self addChildViewController:NAV];
}
#pragma mark <LFTabBarDelegate> 用来实现tabbar 按钮点击事件
-(void)tabBar:(LFTabBar *)tabBar didClickBtn:(NSInteger)index{
    self.selectedIndex = index;
}
@end
