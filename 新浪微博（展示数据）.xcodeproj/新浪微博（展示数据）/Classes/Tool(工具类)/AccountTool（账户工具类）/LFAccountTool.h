//
//  LFAccountTool.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/10.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LFAccountModel;
@interface LFAccountTool : NSObject
/**
 *  存储账号信息（access-token 和 name）
 *
 *  @param account
 */
+(void)saveAccountWithAccount:(LFAccountModel *)account;
/**
 *  获得存储的账号信息
 *
 *  @return
 */
+(LFAccountModel *)getAccount;
/**
 *  发送请求获得accesstoken
 *
 *  @param code    code
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)getAccessTokenWith:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;
 @end
