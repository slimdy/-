//
//  LFUserTool.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/11.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFRequestUnreadResultModel.h"
#import "LFRequestUserInfoResultModel.h"
@interface LFUserTool : NSObject
/**
 *  获得用户未读消息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)getUnreadWithSuccess:(void(^)(LFRequestUnreadResultModel *resultModel))success failure:(void(^)(NSError *error))failure;
/**
 *  获得用户信息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)getUserinfoWithSuccess:(void(^)(LFRequestUserInfoResultModel *resultModel))success failure:(void(^)(NSError *error))failure;
@end
