//
//  LFRequestWeiBoTool.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/11.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFRequestWeiBoTool : NSObject
/**
 *  请求新微博
 *
 *  @param since_id 最新微博ID
 *  @param success  成功回调
 *  @param failure  失败回调
 */
+(void)requestNewWeiBoWithSinceId:(NSString *)since_id success:(void(^)(NSArray *responseArr))success failure:(void(^)(NSError *error))failure;
/*
*  请求旧微博
*
*  @param since_id 最老微博ID
*  @param success  成功回调
*  @param failure  失败回调
*/
+(void)requestNewWeiBoWithMaxId:(NSString *)max_id success:(void(^)(NSArray *responseArr))success failure:(void(^)(NSError *error))failure;
@end
