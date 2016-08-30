//
//  LFRequestUnreadResultModel.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/11.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFRequestUnreadResultModel.h"

@implementation LFRequestUnreadResultModel
/**
 *  返回message类别里未读的总数
 *
 *  @return
 */
- (int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}
/**
 *  返回所有未读的总数
 *
 *  @return
 */
- (int)totoalCount
{
    return self.messageCount + _status + _follower;
}

@end
