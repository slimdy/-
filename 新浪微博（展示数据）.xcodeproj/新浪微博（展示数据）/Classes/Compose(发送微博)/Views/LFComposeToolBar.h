//
//  LFComposeToolBar.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/16.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LFComposeToolBar;
@protocol LFComposeToolBarDelegate <NSObject>
-(void)composeToolBar:(LFComposeToolBar*)composeToolBar didClickBtn:(UIButton *)btn;
@end
@interface LFComposeToolBar : UIView
@property(nonatomic,weak)id<LFComposeToolBarDelegate> delegate;
@end
