//
//  LFNewFeatureCollectionViewController.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/9.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFNewFeatureCollectionViewController.h"
#import "LFNewFeatureCollectionViewCell.h"
@interface LFNewFeatureCollectionViewController ()<UIScrollViewDelegate>
/**
 *  分页器
 */
@property (nonatomic,weak)UIPageControl *pageControl;
@end

@implementation LFNewFeatureCollectionViewController
/**
 *  定义一个重用的ID
 */
static NSString * const reuseIdentifier = @"Cell";
/**
 *  重写init方法
 *
 *  @return 本类的实例化对象
 */
-(instancetype)init{
    //设置collectionView为流水化布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置每一个元素的size
    layout.itemSize = MainScreen.bounds.size;
    //设置滚动方向为水平
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置行间距为0
    layout.minimumLineSpacing = 0;
    //通过布局生成实例化对象
    return [super initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //一定要注册cell
    [self.collectionView registerClass:[LFNewFeatureCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //是否分页
    self.collectionView.pagingEnabled = YES;
    //是否弹跳作用
    self.collectionView.bounces = NO;
    //是否显示水平方向的滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    //设置分页器
    [self setPageControl];
 }

-(void)setPageControl{
    //无需设置大小，只要设置位置
    UIPageControl * pageControl = [[UIPageControl alloc]init];
    //分页个数
    pageControl.numberOfPages = 4;
    //分页指示器的颜色
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    //分页指示器当前页指示器的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    //设置位置，大小不用设置
    pageControl.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.9);
    self.pageControl = pageControl;
    //添加到View上不能添加到contenView 上面，因为collectionView 会随着滚动而移位
    //self.view 当前页面
    //self.collectionView 是所有的元素所组成的页面
    [self.view addSubview:pageControl];
}
#pragma mark -- <UIScrollViewDelegate> --在滚动式触发
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //当前页面的偏移量/整个页面的宽度 如果大于一半，则翻页 int 是取整的
    int page = scrollView.contentOffset.x/scrollView.bounds.size.width + 0.5;
    //当前页标给分页器
    self.pageControl.currentPage = page;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>--返回展示几组

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark <UICollectionViewDataSource>-- 返回1组多少个元素
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
#pragma mark <UICollectionViewDataSource>--返回索要展示的元素
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //循环利用创建自定义的Cell
    LFNewFeatureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
    //ios 8 需要设置5 6 6s以上屏幕适配 ios9 貌似不需要，还带考察
    if(MainScreen.bounds.size.height > 480){
//        imageName = [NSString stringWithFormat:@"new_feature_%ld-568h@2x",indexPath.row +1];
    }
    UIImage *image = [UIImage imageNamed:imageName];
    //将图片传入CELL
    cell.image = image;
    //设置cell 内部按钮将在那个cell 里面显示
    [cell setIndexPath:indexPath count:4];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
