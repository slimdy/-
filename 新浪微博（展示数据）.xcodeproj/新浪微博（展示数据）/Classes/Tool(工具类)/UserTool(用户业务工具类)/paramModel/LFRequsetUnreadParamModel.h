//
//  LFRequsetUnreadParamModel.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/11.
//  Copyright © 2016年 slimdy. All rights reserved.
//
/**
 *  因为从新浪的服务器获取未读消息数据时会用到access——toke 和 uid 所以定义一个参数模型，用来请求数据
 */
#import "LFRequestBaseModel.h"

@interface LFRequsetUnreadParamModel : LFRequestBaseModel
/**
 *  当前登录用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;
@end
