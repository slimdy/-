//
//  LFOriginalWeiBoView.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/12.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFOriginalWeiBoView.h"
#import "LFWeiBoViewModel.h"
#import "LFWeiBoModel.h"
#import "LFPhotoesView.h"
#import "UIImageView+WebCache.h"
@interface LFOriginalWeiBoView()
/**
 *  原创微博内部也包含了6个主要控件
 *
 *
 *
 *
 */
// 头像
@property (nonatomic, weak) UIImageView *iconView;


// 昵称
@property (nonatomic, weak) UILabel *nameView;


// vip
@property (nonatomic, weak) UIImageView *vipView;


// 时间
@property (nonatomic, weak) UILabel *timeView;

// 来源
@property (nonatomic, weak) UILabel *sourceView;


// 正文
@property (nonatomic, weak) UILabel *textView;
/**
 *  配图
 */
@property (nonatomic,weak) LFPhotoesView *photoesView;

@end
@implementation LFOriginalWeiBoView
/**
 *  在外界调用init 方法初始化 控件时，会调用initwithframe 方法，重写这个方法可以自定义这个控件的内容
 *
 *  @param frame
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置6个主要控件
        [self setAllChildView];
        //因为本控件是继承自UIimageView的，所以要设置可与用户交互
        self.userInteractionEnabled = YES;
        /**
         *  设置原创微博的背景图片
         */
        self.image = [UIImage imageWithStretchableImage:[UIImage imageNamed:@"timeline_card_top_background"]];
    }
    return self;
}
/**
 *  添加6个子控件到视图
 */
-(void) setAllChildView{
    UIImageView *iconView = [[UIImageView alloc]init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    UILabel *nameView = [[UILabel alloc]init];
    nameView.font = LFNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    UIImageView *vipView = [[UIImageView alloc]init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    UILabel *timeView = [[UILabel alloc]init];
    timeView.font = LFTimeFont;
    [self addSubview:timeView];
    _timeView = timeView;
    
    UILabel *sourceView = [[UILabel alloc]init];
    sourceView.font = LFSourceFont;
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    UILabel *textView = [[UILabel alloc]init];
    textView.font = LFTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    LFPhotoesView *photoesView = [[LFPhotoesView alloc]init];
    _photoesView = photoesView;
    [self addSubview:photoesView];
    
}
/**
 *  获得外界传入的数据，并且通过数据计算6个控件的大小
 *
 *  @param weiBoVM
 */
-(void)setWeiBoVM:(LFWeiBoViewModel *)weiBoVM{
    _weiBoVM = weiBoVM;
    //设置控件数据
    [self setData];
    //计算控件大小
    [self setFrame];
    
}
-(void)setData{
    //网络请求图片用sdimage
    [_iconView sd_setImageWithURL:self.weiBoVM.weibo.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    //如果是vip//设置名称
    if (self.weiBoVM.weibo.user.vip) {
        _nameView.textColor = [UIColor orangeColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    
    _nameView.text = self.weiBoVM.weibo.user.name;
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",self.weiBoVM.weibo.user.mbrank];
    //设置vip
    _vipView.image = [UIImage imageNamed:imageName];
    //设置时间
    _timeView.text = self.weiBoVM.weibo.created_at;
    //设置来源
    _sourceView.text = [NSString stringWithFormat:@"来自于 %@",[self filterHTML:self.weiBoVM.weibo.source]];
    //设置正文
    _textView.text = self.weiBoVM.weibo.text;
  
        _photoesView.pic_urls = self.weiBoVM.weibo.pic_urls;
   
  
    
}
/**
 *  将视图模型中计算好的fram 赋值给自身控件的frame
 */
-(void)setFrame{
    
    _iconView.frame = _weiBoVM.originalIconFrame;
    _nameView.frame = _weiBoVM.originalNameFrame;
    if (_weiBoVM.weibo.user.vip) {
        _vipView.hidden = NO;
        _vipView.frame = _weiBoVM.originalVipFrame;
    }else{
        _vipView.hidden = YES;
        
    }
    /**
     *  这里不用设置时间和来源了，因为时间每次要和系统的时间作比较,而这个方法只会在传值的时候调用一次，比如一条微博刚拿到的时候时间是刚刚，当cell重用的时候，会重新读取时间，发现已经是2分钟前，而frame 已经是第一次刚刚的frame  这样会出现放不下的问题. 来源的frame 依靠着
     */
    
    //时间
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameView.frame)+LFWeiboCellMargin * 0.5;
    CGSize timeSize = [self.weiBoVM.weibo.created_at sizeWithAttributes:@{NSFontAttributeName:LFTimeFont}];
    _timeView.frame = (CGRect){{timeX,timeY},timeSize};
    //来源
    CGFloat sourceX = CGRectGetMaxX(_timeView.frame)+LFWeiboCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self.weiBoVM.weibo.source sizeWithAttributes:@{NSFontAttributeName:LFTimeFont}];
    _sourceView.frame = (CGRect){{sourceX,sourceY},sourceSize};
//    _timeView.frame = _weiBoVM.originalTimeFrame;
    //_sourceView.frame = _weiBoVM.originalSourceFrame;
    _textView.frame = _weiBoVM.originalTextFrame;
    
    //设置配图
    
        _photoesView.frame =_weiBoVM.OriginalPhotoesViewFram;
  
    
}
/**
 *  过滤html 获得数据
 *
 *  @param html
 *
 *  @return 
 */
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}
@end
