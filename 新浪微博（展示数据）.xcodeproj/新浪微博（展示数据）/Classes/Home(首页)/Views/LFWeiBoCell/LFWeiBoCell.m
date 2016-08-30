//
//  LFWeiBoCell.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/12.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFWeiBoCell.h"
#import "LFOriginalWeiBoView.h"
#import "LFRetweetWiboView.h"
#import "LFWeiBoToolView.h"
#import "LFWeiBoViewModel.h"
@interface LFWeiBoCell()
/**
 *  cell的内部分成三个模块，原创，转发，工具条
 */
@property (nonatomic,weak) LFOriginalWeiBoView *originalWeiboView;
@property (nonatomic,weak) LFRetweetWiboView *retweetWeiboView;
@property (nonatomic,weak) LFWeiBoToolView *toolView;
@end
@implementation LFWeiBoCell
/**
 *  外界调用的类方法，用来创建cell
 *
 *  @param tableView
 *
 *  @return
 */
+(instancetype)createWeiBoCellWith:(UITableView *)tableView{
    static NSString *ID = @"cell";
    LFWeiBoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
/**
 *  重写initWithStyle方法，用来设置cell
 *
 *  @param style           <#style description#>
 *  @param reuseIdentifier <#reuseIdentifier description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加三大子控件
        [self setAllChildView];
        //清除cell的背景颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
/**
 *  初始化三大控件
 */
-(void)setAllChildView{
    LFOriginalWeiBoView *originalWeiboView = [[LFOriginalWeiBoView alloc]init];
    [self addSubview:originalWeiboView];
    LFRetweetWiboView *retweetWeiboView =[[LFRetweetWiboView alloc]init];
    [self addSubview:retweetWeiboView];
    LFWeiBoToolView *toolView = [[LFWeiBoToolView alloc]init];
    [self addSubview:toolView];
    _originalWeiboView = originalWeiboView;
    _retweetWeiboView = retweetWeiboView;
    _toolView = toolView;
}
/**
 *  处理传过来的数据
 *
 *  @param weiBoVM <#weiBoVM description#>
 */
-(void)setWeiBoVM:(LFWeiBoViewModel *)weiBoVM{
    _weiBoVM = weiBoVM;
    //设置原创微博的frame 并且把子控件的frame 也传入
   _originalWeiboView.frame = weiBoVM.originalViewFrame;
    _originalWeiboView.weiBoVM = weiBoVM;
    //设置转发微博的frame 并且把子控件的frame 也传入
    _retweetWeiboView.frame = weiBoVM.retweetViewFrame;
    _retweetWeiboView.weiBoVM = weiBoVM;
    
    //设置工具条的frame
   _toolView.frame = weiBoVM.toolViewFrame;
    _toolView.weiBoVM = weiBoVM;
}

@end
