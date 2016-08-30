//
//  LFComposeTool.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/16.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFComposeTool : NSObject
+(void)composeTextUrl:(NSString *)url parameters:(NSString*)weiBo success:(void(^)())success failure:(void(^)(NSError*))failure;
+(void)composeImageWithImage:(UIImage *)image weibo:(NSString *)weibo success:(void(^)())success failure:(void(^)(NSError *error))failure;
@end
