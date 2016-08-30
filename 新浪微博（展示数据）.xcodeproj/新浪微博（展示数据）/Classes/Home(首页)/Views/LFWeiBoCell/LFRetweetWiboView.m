//
//  LFRetweetWiboView.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/12.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFRetweetWiboView.h"
#import "LFWeiBoViewModel.h"
#import "LFWeiBoModel.h"
#import "LFPhotoesView.h"
@interface LFRetweetWiboView ()

// 昵称
@property (nonatomic, weak) UILabel *nameView;


// 正文
@property (nonatomic, weak) UILabel *textView;


// 配图
@property (nonatomic,weak)LFPhotoesView *photoesView;

@end
/**
 道理与设置原创微博相同
 
 - returns:
 */
@implementation LFRetweetWiboView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setAllChildView];
        self.image = [UIImage imageWithStretchableImage:[UIImage imageNamed:@"timeline_retweet_background"]];
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void) setAllChildView{

    
    UILabel *nameView = [[UILabel alloc]init];
    nameView.font = LFNameFont;
    nameView.textColor = [UIColor blueColor];
    [self addSubview:nameView];
    _nameView = nameView;
    
    
    UILabel *textView = [[UILabel alloc]init];
    textView.font = LFTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    LFPhotoesView *photoesView = [[LFPhotoesView alloc]init];
    _photoesView = photoesView;

    [self addSubview:photoesView];
    
}
-(void)setWeiBoVM:(LFWeiBoViewModel *)weiBoVM{
    _weiBoVM =weiBoVM;
    
    _nameView.frame = weiBoVM.retweetlNameFrame;
    _nameView.text = weiBoVM.weibo.retweetedName;
    _textView.frame = weiBoVM.retweetlTextFrame;
    _textView.text = weiBoVM.weibo.retweeted_status.text;
    
        _photoesView.frame = weiBoVM.retweetlPhotoesViewFram;
        _photoesView.pic_urls = weiBoVM.weibo.retweeted_status.pic_urls;
    
   
}
@end
