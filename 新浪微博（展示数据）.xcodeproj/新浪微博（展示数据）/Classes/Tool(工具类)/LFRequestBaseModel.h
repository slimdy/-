//
//  LFRequestBaseModel.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/11.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFRequestBaseModel : NSObject
/**
 *  所有的请求参数模型都会用到access_token，所以把它设置为父类
 */
@property (nonatomic,copy)NSString *access_token;
@end
