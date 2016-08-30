//
//  LFNewFeatureCollectionViewCell.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/9.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFNewFeatureCollectionViewCell.h"
#import "LFTabBarController.h"
@interface LFNewFeatureCollectionViewCell()
@property (nonatomic,weak)UIImageView *imageView;
@property (nonatomic,weak)UIButton *shareBtn;
@property (nonatomic,weak)UIButton *startBtn;

@end
@implementation LFNewFeatureCollectionViewCell
/**
 *  懒加载图片View
 *
 *  @return <#return value description#>
 */
-(UIImageView *)imageView{
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc]init];
        _imageView = imageView;
        //一定要添加在self.contenView 因为这是最外层显示的View
        [self.contentView addSubview:imageView];
    }
    return _imageView;
}
/**
 *  分享按钮的懒加载
 *
 *  @return 分享按钮， 这里不设置位置，一般在layoutsubview里面设置
 */
-(UIButton *)shareBtn{
    if (_shareBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        //设置了选中的图片，但不知为什么无法选中
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //根据图片和文字，自适应大小
        [btn sizeToFit];
        [self.contentView addSubview:btn];
        _shareBtn = btn;
    }
    return _shareBtn;
}
/**
 *  开始微博按钮的懒加载
 *
 *  @return 返回开始微博按钮
 */
-(UIButton *)startBtn{
    if (_startBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"开始微博" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //根据图片和文字，自适应大小
        [btn sizeToFit];
        [self.contentView addSubview:btn];
        _startBtn = btn;
    }
    return _startBtn;
}
/**
 *  设置哪些页面显示按钮，哪些不用
 *
 *  @param indexPath 当前cell的索引
 *  @param count     所有cell的数量
 */
-(void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count{
    //当当前cell如果是最后一页 则展示按钮
    if (indexPath.row == count - 1) {
        self.shareBtn.hidden = NO;
        self.startBtn.hidden = NO;
    }else{//不是最后一页隐藏按钮
        self.shareBtn.hidden = YES;
        self.startBtn.hidden = YES;
    }
}
/**
 *  点击开始微博  将根控制器，转换给tabBarController
 */
-(void)startBtnClick{
    LFTabBarController *tabBarVC = [[LFTabBarController alloc]init];
    LFKeyWindow.rootViewController = tabBarVC;
}
/**
 *  在拿到外界给的图片是，将它添加到ImageView上
 *
 *  @param image 外界添加的图片
 */
-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}
/**
 *  重新布局cell内部的子控件
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    
    self.shareBtn.center = CGPointMake(self.width * 0.5, self.height *0.7);
    self.startBtn.center = CGPointMake(self.width * 0.5 , self.height * 0.8);
}

@end
