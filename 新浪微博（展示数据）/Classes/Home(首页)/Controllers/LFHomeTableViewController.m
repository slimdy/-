//
//  LFHomeTableViewController.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/8.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFHomeTableViewController.h"
#import "LFPopMenuView.h"
#import "LFCoverView.h"
#import "LFHomeTitleView.h"
#import "LFPopMenuTableViewController.h"
#import "LFNextViewController.h"
@interface LFHomeTableViewController ()<LFCoverViewDelegate>
/**
 *  头部titleView
 */
@property (nonatomic,weak) LFHomeTitleView *titleView;
/**
 *  弹出菜单选择控制器
 */
@property (nonatomic,strong)LFPopMenuTableViewController *popViewController;
@end

@implementation LFHomeTableViewController
/**
 *  懒加载菜单控制器
 *
 *  @return <#return value description#>
 */
-(LFPopMenuTableViewController *)popViewController{
    if (_popViewController == nil) {
        _popViewController = [[LFPopMenuTableViewController alloc]init];
    }
    return _popViewController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置右边navigationItem
    UIImage *rightImage =[UIImage imageNamed:@"navigationbar_pop"];
    UIImage *rightSelectedImage =[UIImage OriginalImageWith:@"navigationbar_pop_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithNormalImage:rightImage SelectedImage:rightSelectedImage target:self Sel:@selector(popClick) forControlEvents:UIControlEventTouchUpInside];
    //设置左边navigationItem
    UIImage *leftImage = [UIImage imageNamed:@"navigationbar_friendsearch"];
    UIImage *leftSelectedImage = [UIImage OriginalImageWith:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithNormalImage:leftImage SelectedImage:leftSelectedImage target:self Sel:@selector(friendSearch) forControlEvents:UIControlEventTouchUpInside];
    //设置中间头部titleView
    LFHomeTitleView *titleView = [LFHomeTitleView buttonWithType:UIButtonTypeCustom];
    self.titleView = titleView;
    [self.titleView setTitle:@"首页" forState:UIControlStateNormal];
    [self.titleView setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [self.titleView setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    [self.titleView addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView =self.titleView;
}

/**
 *  点击头部titleView 时触发，显示蒙版和菜单控制器
 *
 *  @param btn <#btn description#>
 */
-(void)titleClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    //创建蒙版，蒙版是为了防止用户误触
    LFCoverView * coverView = [LFCoverView show];
    coverView.delegate = self;
    CGFloat PopViewW = 150;
    CGFloat PopViewH = 200;
    CGFloat PopViewX = self.view.width/2 - PopViewW/2;
    CGFloat PopViewY = 55;
    LFPopMenuView *popView = [LFPopMenuView showInRect:CGRectMake(PopViewX, PopViewY, PopViewW, PopViewH)];
    //将菜单控制器的页面加载到菜单页面上
    popView.contentView = self.popViewController.tableView;
}
/**
 *  点击右侧按钮触发
 */
-(void)popClick{
   
}
/**
 *  点击左侧添加朋友页面触发
 */
-(void)friendSearch{
    // xib 的加载有几种 默认init方法就能加载，先找LFNextView.xib 再找LFNextViewController.Xib
    LFNextViewController *VC = [[LFNextViewController alloc]initWithNibName:nil bundle:nil];
    //隐藏nextViewController的tabBAR ,这里要注意， 自定义的tabbar 无法隐藏，所以自定义的tabar 要添加到系统自带的tabbar上，然后在删除系统的tabbarbutton
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mask -LFCoverViewDelegate--蒙版的代理方法，当蒙版被点击是触发
-(void)coverViewDIdClicKWith:(LFCoverView *)coverView{
    //隐藏菜单
    [LFPopMenuView hide];
    self.titleView.selected = NO;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
