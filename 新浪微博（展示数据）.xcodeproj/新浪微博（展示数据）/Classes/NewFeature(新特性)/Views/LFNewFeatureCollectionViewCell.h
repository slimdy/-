//
//  LFNewFeatureCollectionViewCell.h
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/9.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFNewFeatureCollectionViewCell : UICollectionViewCell
/**
 *  需要外界传入的，cell显示的图片
 */
@property (nonatomic,weak)UIImage *image;
/**
 *  设置哪些页面显示按钮，哪些不用
 *
 *  @param indexPath 当前cell的索引
 *  @param count     所有cell的数量
 */
-(void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;
@end
