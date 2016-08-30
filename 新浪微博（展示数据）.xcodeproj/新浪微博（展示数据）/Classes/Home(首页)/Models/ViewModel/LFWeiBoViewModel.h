//
//  LFWeiBoViewModel.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/12.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LFWeiBoModel;
@interface LFWeiBoViewModel : NSObject

/**
 *  微博数据 LFWeiBoModel
 */
@property (nonatomic,strong)LFWeiBoModel *weibo;

/**
 *  原创微博frame
 */
@property (nonatomic,assign) CGRect originalViewFrame;
//头像
@property (nonatomic,assign) CGRect originalIconFrame;
//名称
@property (nonatomic,assign) CGRect originalNameFrame;
//vip
@property (nonatomic,assign) CGRect originalVipFrame;
//时间
@property (nonatomic,assign) CGRect originalTimeFrame;
//来源
@property (nonatomic,assign) CGRect originalSourceFrame;
//正文
@property (nonatomic,assign) CGRect originalTextFrame;
/**
 *  配图ViewFrame
 */
@property (nonatomic,assign) CGRect OriginalPhotoesViewFram;
/**
 *  转发微博frame
 */
@property (nonatomic,assign) CGRect retweetViewFrame;
//名称
@property (nonatomic,assign) CGRect retweetlNameFrame;
//正文
@property (nonatomic,assign) CGRect retweetlTextFrame;
/**
 *  配图ViewFrame
 */
@property (nonatomic,assign) CGRect retweetlPhotoesViewFram;
/**
 *  工具条frame
 */
@property (nonatomic,assign) CGRect toolViewFrame;
/**
 *  整个cell的高度
 */
@property (nonatomic,assign)CGFloat cellHeight;

@end
