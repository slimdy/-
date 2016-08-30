//
//  LFUserModel.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/10.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFUserModel.h"

@implementation LFUserModel
/**
 *   会员类型 > 2代表是会员
 *
 *  @param mbtype
 */
- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;//如果大于2 则说明是vip
}
@end
