//
//  LFWeiBoViewModel.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/12.
//  Copyright © 2016年 slimdy. All rights reserved.
//



/**
 * MVVM 视图模型设计思想，就是在传入数据的时候，也将控件的大小设置完成
 *
 *  
 */
#import "LFWeiBoViewModel.h"
#import "LFWeiBoModel.h"
@implementation LFWeiBoViewModel
/**
 *  当外界给这个模型视图传数据来的时候，需要计算各个控件的frame
 *
 *  @param weibo
 */
-(void)setWeibo:(LFWeiBoModel *)weibo{
    _weibo = weibo;
    //设置原创微博view的大小
    [self setOriginalWeiboFrame];
    //如果只有原创微博 则直接计算工具条的y值
    CGFloat toolY = CGRectGetMaxY(_originalViewFrame);
    //如果有转发微博
    if (weibo.retweeted_status) {
        //计算转发微博的frame
        [self setRetweetWeiBoFrame];
        //工具条的Y 就等于转发微博的y
        toolY = CGRectGetMaxY(_retweetViewFrame);
    }
    //计算toolView的frame
    CGFloat toolX = 0;
    CGFloat toolW = LFScreenW;
    CGFloat toolH = 35;
    _toolViewFrame = CGRectMake(toolX, toolY, toolW, toolH);
    // 整个cell的高度是 工具条的最大Y值
    _cellHeight = CGRectGetMaxY(_toolViewFrame);
}
/**
 *  设置原创微博的frame
 */
-(void)setOriginalWeiboFrame{
    //头像
    CGFloat iconX = LFWeiboCellMargin;
    CGFloat iconY = iconX;
    CGFloat iconW = LFIconWH;
    CGFloat iconH = LFIconWH;
    _originalIconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    //名称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame)+ LFWeiboCellMargin;
    CGFloat nameY = iconY;
    CGSize nameSize = [_weibo.user.name sizeWithAttributes:@{NSFontAttributeName:LFNameFont}];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    //vip
    if (_weibo.user.vip) {
        CGFloat vipX = CGRectGetMaxX(self.originalNameFrame)+LFWeiboCellMargin;
        CGFloat vipY = iconY;
        CGFloat vipH = 14;
        CGFloat vipW = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    /**
     *  这里不用设置时间和来源了，因为时间每次要和系统的时间作比较,而这个方法只会在传值的时候调用一次，比如一条微博刚拿到的时候时间是刚刚，当cell重用的时候，会重新读取时间，发现已经是2分钟前，而frame 已经是第一次刚刚的frame  这样会出现放不下的问题，所以需要在 它的设置时间显示的时候在此计算frame （LFOriginalweiboView）
     */
//    //时间
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(_originalNameFrame)+LFWeiboCellMargin * 0.5;
//    CGSize timeSize = [_weibo.created_at sizeWithAttributes:@{NSFontAttributeName:LFTimeFont}];
//    _originalTimeFrame = (CGRect){{timeX,timeY},timeSize};
//    //来源
//    CGFloat sourceX = CGRectGetMaxX(_originalTimeFrame)+LFWeiboCellMargin;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [_weibo.source sizeWithAttributes:@{NSFontAttributeName:LFTimeFont}];
//    _originalSourceFrame = (CGRect){{sourceX,sourceY},sourceSize};
    //正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + LFWeiboCellMargin;
    CGFloat textW = LFScreenW - 2*LFWeiboCellMargin;
    CGSize  textSize = [_weibo.text sizeWithFont:LFTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    CGFloat originalH = CGRectGetMaxY(_originalTextFrame) + LFWeiboCellMargin;
    if (_weibo.pic_urls.count) {
        CGFloat photoesX = LFWeiboCellMargin;
        CGFloat photoesY = CGRectGetMaxY(_originalTextFrame)+LFWeiboCellMargin;
        CGSize photoesSize =[self setPhotoesViewSizeWithCount:_weibo.pic_urls.count];
        _OriginalPhotoesViewFram = (CGRect){{photoesX,photoesY},photoesSize};
         originalH = CGRectGetMaxY(_OriginalPhotoesViewFram) + LFWeiboCellMargin;
    }
    
    //计算原创微博Frame
    CGFloat originalX = 0;
    // 这里的y 不要贴到cell的顶部 留取10像素的空间
    CGFloat originalY = LFWeiboCellMargin;
    CGFloat originalW = LFScreenW;
    
    _originalViewFrame = CGRectMake(originalX, originalY, originalW, originalH);
}
/**
 *  设置转发微博的frame
 */
-(void)setRetweetWeiBoFrame{
    //名称
    CGFloat nameX = LFWeiboCellMargin;
    CGFloat nameY = nameX;
    CGSize nameSize = [_weibo.retweetedName sizeWithAttributes:@{NSFontAttributeName:LFNameFont}];
    _retweetlNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    //正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetlNameFrame)+LFWeiboCellMargin;
    CGFloat textW = LFScreenW - 2*LFWeiboCellMargin;;
    CGSize  textSize = [_weibo.retweeted_status.text sizeWithFont:LFTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    self.retweetlTextFrame = (CGRect){{textX,textY},textSize};
    CGFloat retweetH = CGRectGetMaxY(_retweetlTextFrame) + LFWeiboCellMargin;
    if (_weibo.retweeted_status.pic_urls.count) {
        CGFloat photoesX = LFWeiboCellMargin;
        CGFloat photoesY = CGRectGetMaxY(_retweetlTextFrame)+LFWeiboCellMargin;
        CGSize photoesSize =[self setPhotoesViewSizeWithCount:_weibo.retweeted_status.pic_urls.count];
        _retweetlPhotoesViewFram = (CGRect){{photoesX,photoesY},photoesSize};
        retweetH = CGRectGetMaxY(_retweetlPhotoesViewFram) + LFWeiboCellMargin;
    }
    // 转发微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = LFScreenW;
    
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
}
-(CGSize)setPhotoesViewSizeWithCount:(NSInteger)photoesCount{
    
    NSInteger cols = photoesCount == 4?2:3;
    NSInteger rows = (photoesCount-1)/cols+1;
    CGFloat photoWH = 90;
    CGFloat photoesH = photoWH * rows +(rows-1)*LFWeiboCellMargin;
    CGFloat photoesW = photoWH * cols +(cols - 1)*LFWeiboCellMargin;
    CGSize size = CGSizeMake(photoesW, photoesH);
    return size;
}
@end
