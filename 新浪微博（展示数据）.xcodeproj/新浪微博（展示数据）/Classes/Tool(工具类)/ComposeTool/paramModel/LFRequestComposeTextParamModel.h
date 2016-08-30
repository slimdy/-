//
//  LFRequestComposeTextParamModel.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/16.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFRequestBaseModel.h"
@interface LFRequestComposeTextParamModel :LFRequestBaseModel
/**
 *  发送微博的内容
 */
@property (nonatomic,strong)NSString *status;
@end
