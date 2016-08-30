//
//  LFOriginalWeiBoView.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/12.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LFWeiBoViewModel;
@interface LFOriginalWeiBoView : UIImageView
/**
 *  微博的数据模型视图
 */
@property (nonatomic,strong) LFWeiBoViewModel *weiBoVM;
@end
