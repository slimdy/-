//
//  LFRequestUserInfoParamModel.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/12.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFRequsetUnreadParamModel.h"
/*
*  因为从新浪的服务器获取用户信息消息数据时会用到access——toke 和 uid 所以定义一个参数模型，用来请求数据
*/
@interface LFRequestUserInfoParamModel : LFRequsetUnreadParamModel

@end
