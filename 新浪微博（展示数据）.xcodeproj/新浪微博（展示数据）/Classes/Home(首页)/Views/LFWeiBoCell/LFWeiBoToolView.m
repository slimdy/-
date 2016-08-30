//
//  LFWeiBoToolView.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/12.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFWeiBoToolView.h"
#import "LFWeiBoModel.h"
#import "LFWeiBoViewModel.h"
@interface LFWeiBoToolView()
@property (nonatomic,weak)UIButton *retweet;
@property (nonatomic,weak)UIButton *comments;
@property (nonatomic,weak)UIButton *like;
@property (nonatomic,strong)NSMutableArray *divideArr;
@property (nonatomic,strong)NSMutableArray *btnArr;
@end
@implementation LFWeiBoToolView
-(NSMutableArray *)divideArr{
    if (_divideArr == nil) {
        _divideArr = [NSMutableArray array];
    }
    return _divideArr;
}
-(NSMutableArray *)btnArr{
    if (_btnArr == nil) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setUpAllChildView{
    UIButton *retweet = [self setOneButtonOfToolViewWithImage:[UIImage imageNamed:@"timeline_icon_retweet"] andTitle:@"转发"];
    _retweet = retweet;
    UIButton *comments = [self setOneButtonOfToolViewWithImage:[UIImage imageNamed:@"timeline_icon_comment"] andTitle:@"评论"];
    _comments = comments;
    UIButton *like = [self setOneButtonOfToolViewWithImage:[UIImage imageNamed:@"timeline_icon_unlike"] andTitle:@"赞"];
    _like = like;
    for(NSInteger i = 0;i<2;i++){
        UIImageView *divideView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:divideView];
        [self.divideArr addObject:divideView];
    }
}
-(UIButton *)setOneButtonOfToolViewWithImage:(UIImage *)image andTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [self.btnArr addObject:btn];
    [self addSubview:btn];
    return btn;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnH = self.height;
    CGFloat btnW = self.width/3;
    for (NSInteger i=0 ; i < self.btnArr.count; i++) {
        UIButton *btn = self.btnArr[i];
        btn.frame = CGRectMake(btnW * i,0, btnW, btnH);
    }
    NSInteger i = 1;
    for (UIImageView *divide in self.divideArr) {
      UIButton *btn = self.btnArr[i];
        divide.x =btn.x;
        i++;
    }    
    
}
-(void)setWeiBoVM:(LFWeiBoViewModel *)weiBoVM{
    _weiBoVM = weiBoVM;
    [self setBtn:_retweet WithData:weiBoVM.weibo.reposts_count];
    [self setBtn:_comments WithData:weiBoVM.weibo.comments_count];
    [self setBtn:_like WithData:weiBoVM.weibo.attitudes_count];
    
}
-(void)setBtn:(UIButton *)btn WithData:(int)count{
    if (count == 0) {
        return;
    }
    NSString *title = [NSString stringWithFormat:@"%d",count];
    if (count >= 10000) {
        float floatcount = count / 10000.0;
        title = [NSString stringWithFormat:@"%.1f万",floatcount];
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
}
@end
