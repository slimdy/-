//
//  LFATRequestParamModel.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/11.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  这个参数命名不太规范，在这里做个结束，这个是用来请求accesstoken的请求参数模型
 */
@interface LFATRequestParamModel : NSObject

/**
 * appkey
 */
@property (nonatomic,copy)NSString *client_id;
/**
 * appsecret
 */
@property (nonatomic,copy)NSString *client_secret;
/**
 *@"authorization_code"
 */
@property (nonatomic,copy)NSString *grant_type;
/**
 * code
 */
@property (nonatomic,copy)NSString *code;
/**
 * 回调地址
 */
@property (nonatomic,copy)NSString *redirect_uri;
@end
