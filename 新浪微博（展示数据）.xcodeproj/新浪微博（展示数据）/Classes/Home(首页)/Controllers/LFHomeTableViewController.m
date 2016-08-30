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
#import "LFAccountTool.h"
#import "LFAccountModel.h"
#import "LFWeiBoModel.h"
#import "LFRequestWeiBoTool.h"
#import "LFUserTool.h"
#import "LFWeiBoViewModel.h"
#import "LFWeiBoCell.h"

#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"

@interface LFHomeTableViewController ()<LFCoverViewDelegate>
/**
 *  头部titleView
 */
@property (nonatomic,weak) LFHomeTitleView *titleView;
/**
 *  弹出菜单选择控制器
 */
@property (nonatomic,strong)LFPopMenuTableViewController *popViewController;
/**
 *  所有weibo模型的数组
 */
@property (nonatomic,strong)NSMutableArray  *weibosVM;
@end

@implementation LFHomeTableViewController
/**
 *  懒加载数组
 *
 *  @return
 */
-(NSMutableArray *)weibosVM{
    if(_weibosVM == nil){
        _weibosVM = [NSMutableArray array];
    }
    return _weibosVM;
}
/**
 *  懒加载菜单控制器
 *
 *  @return 菜单控制器
 */
-(LFPopMenuTableViewController *)popViewController{
    if (_popViewController == nil) {
        _popViewController = [[LFPopMenuTableViewController alloc]init];
    }
    return _popViewController;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    //设置tableview的背景色
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    //取消cell的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置首页导航条
    [self setNavigationBar];
    //请求最新微博 默认20条
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewWeiBo)];
    //开始时自动刷新
    [self.tableView headerBeginRefreshing];
    //上拉刷新以前的微博
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreWeiBo)];
    //请求用户本人的昵称
    [LFUserTool getUserinfoWithSuccess:^(LFRequestUserInfoResultModel *resultModel) {
        [self.titleView setTitle:resultModel.screen_name forState:UIControlStateNormal];
        //在请求成功后，将用户的昵称存放到ACCountModel 中的name 属性里 并且归档
        LFAccountModel *account = [LFAccountTool getAccount];
        account.name = resultModel.screen_name;
        [LFAccountTool saveAccountWithAccount:account];
    } failure:^(NSError *error) {
        if (error) {
            LFLog(@"%@",error);
        }
    }];
}
/**
 * 刷新首页
 */
-(void)refresh{
    [self.tableView headerBeginRefreshing];
}
/**
 *  第一次加载或者是下拉刷新新的微博
 */
-(void)loadNewWeiBo{
    //设置since——id 这个参数的意义是，给新浪发送，新浪会返回比这个ID 更大的微博，也就是新微博，如果不发送，则返回所有微博（20条）
    NSString *sinceID = nil;
    if (self.weibosVM.count) {
        LFWeiBoViewModel *firstWeiBoVM = self.weibosVM[0];
        sinceID = firstWeiBoVM.weibo .idstr;
    }
    //利用封装的请求微博数据的工具类，请求数据
    [LFRequestWeiBoTool requestNewWeiBoWithSinceId:sinceID success:^(NSArray *responseArr) {
        //展示新微博数
        [self showNewWeiBoCount:responseArr.count];
        //在这里将模型转化成视图模型
        NSMutableArray *newWieBos = [NSMutableArray array];
        for (LFWeiBoModel *weibo in responseArr) {
            LFWeiBoViewModel *weiboVM = [[LFWeiBoViewModel alloc]init];
            weiboVM.weibo = weibo;
            [newWieBos addObject:weiboVM];
        }
        //设置索引
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newWieBos.count)];
        
         //添加到数组牵头
        [self.weibosVM insertObjects:newWieBos atIndexes:indexSet];
        //结束刷新
        [self.tableView headerEndRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        if (error) {
            LFLog(@"%@",error);
            [MBProgressHUD showError:@"网络不给力"];
            [self.tableView headerEndRefreshing];
        }
    }];
}
/**
 *  添加新微博提醒
 *
 *  @param count 新微博个数
 */
-(void)showNewWeiBoCount:(NSInteger)count{
    //如果新微博数是0 则不作操作
    if(count == 0)return;
    //创建 label 用来显示新微薄数据
    CGFloat labelH = 35;
    CGFloat labelX = 0;
    CGFloat labelY = CGRectGetMaxY(self.navigationController.navigationBar.frame)-labelH;
    CGFloat labelW = self.view.width;
    UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    countLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    countLabel.textColor = [UIColor whiteColor];
    countLabel.text = [NSString stringWithFormat:@"最新微博%ld条",(long)count];
    countLabel.textAlignment = NSTextAlignmentCenter;
    //插入到导航控制器下的导航条后面
    [self.navigationController.view insertSubview:countLabel belowSubview:self.navigationController.navigationBar];
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        //下下移动 一个label高度的距离
        countLabel.transform = CGAffineTransformMakeTranslation(0, labelH);
    } completion:^(BOOL finished) {
        //完成后停顿2秒 再返回
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            countLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            //所有动画结束后删除这个label
            [countLabel removeFromSuperview];
        }];
    }];
}
/**
 *  上拉显示更多
 */
-(void)loadMoreWeiBo{
    //设置max——id max——id 传给新浪，新浪会返回 比这个等于这个ID 或者比这个ID 小得数据
    NSString *max_id = nil;
    if (self.weibosVM.count) {
        LFWeiBoViewModel *lastWeiBoVM = self.weibosVM.lastObject;
        NSString * lastWeiBoIdStr = [lastWeiBoVM.weibo idstr];
        //因为是<= 为了避免重复 减1
        long long maxId = [lastWeiBoIdStr longLongValue] - 1;
        max_id = [NSString stringWithFormat:@"%lld",maxId];
    }
    //运用自己的工具类 请求数据
    [LFRequestWeiBoTool requestNewWeiBoWithMaxId:max_id success:^(NSArray *responseArr) {
        //在这里将模型转化成视图模型
        NSMutableArray *newWieBos = [NSMutableArray array];
        for (LFWeiBoModel *weibo in responseArr) {
            LFWeiBoViewModel *weiboVM = [[LFWeiBoViewModel alloc]init];
            weiboVM.weibo = weibo;
            [newWieBos addObject:weiboVM];
        }

        //把跟多的微博数据 添加到所有微博数组的后面
        [self.weibosVM addObjectsFromArray:newWieBos];
        //结束刷新
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        if (error) {
            LFLog(@"%@",error);
            [MBProgressHUD showError:@"网络不给力"];
            [self.tableView footerEndRefreshing];
            
        }
    }];
}
/**
 *  设置首页导航条
 */
-(void)setNavigationBar{
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
    //因为之前归档了用户的用户名，如果是第一次，也就是说没有归档的话，就显示首页，归档了的话显示名称
    NSString *title = [LFAccountTool getAccount].name?[LFAccountTool getAccount].name:@"首页";
    [self.titleView setTitle:title forState:UIControlStateNormal];
    [self.titleView setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [self.titleView setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    [self.titleView addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView =self.titleView;
}
/**
 *  点击头部titleView 时触发，显示蒙版和菜单控制器
 *
 *  @param btn
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weibosVM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LFWeiBoCell *cell = [LFWeiBoCell createWeiBoCellWith:tableView];
    LFWeiBoViewModel *weiboVM = self.weibosVM[indexPath.row];
    cell.weiBoVM = weiboVM;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.weibosVM[indexPath.row] cellHeight];
}

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
