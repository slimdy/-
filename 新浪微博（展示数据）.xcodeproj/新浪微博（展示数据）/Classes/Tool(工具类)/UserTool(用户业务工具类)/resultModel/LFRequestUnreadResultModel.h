//
//  LFRequestUnreadResultModel.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/11.
//  Copyright © 2016年 slimdy. All rights reserved.
//
/**
 *
 * 新浪返回给我们数据的时候，我们用来接收未读消息的模型
 */
#import <Foundation/Foundation.h>

@interface LFRequestUnreadResultModel : NSObject
/**
 *  新微博未读数
 */
@property (nonatomic, assign) int status;
/**
 *  新粉丝数
 */
@property (nonatomic, assign) int follower;
/**
 *  新评论数
 */
@property (nonatomic, assign) int cmt;
/**
 *  新私信数
 */
@property (nonatomic, assign) int dm;
/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) int mention_status;
/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) int mention_cmt;

/**
 *  消息的总和
 */
- (int)messageCount;

/**
 *  未读数的总和
 */
- (int)totoalCount;

@end
