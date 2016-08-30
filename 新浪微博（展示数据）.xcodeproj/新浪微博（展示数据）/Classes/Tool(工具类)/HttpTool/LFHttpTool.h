//
//  LFHttpTool.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/11.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LFRequsetComposeImageParamModel;
@interface LFHttpTool : NSObject
/**
 *  http get 请求
 *
 *  @param urlStr     请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+(void)GET:(NSString *)urlStr parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;
/**
 *  http post 请求
 *
 *  @param urlStr     请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+(void)POST:(NSString *)urlStr parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure;
/**
 *  上传图片
 *
 *  @param urlStr     urlStr
 *  @param parameters 参数
 *  @param param      上传的东西
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+(void)Upload:(NSString *)urlStr parameters:(id)parameters uploadParam:(LFRequsetComposeImageParamModel *)param success:(void(^)())success failure:(void(^)(NSError *))failure;
@end
