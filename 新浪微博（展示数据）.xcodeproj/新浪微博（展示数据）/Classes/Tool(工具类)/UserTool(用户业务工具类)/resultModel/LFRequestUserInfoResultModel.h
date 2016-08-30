//
//  LFRequestUserInfoResultModel.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/12.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  新浪返回给我们数据的时候，我们用来接收用户信息的模型
 */
@interface LFRequestUserInfoResultModel : NSObject
/**
 *  用户昵称
 */
@property (nonatomic,copy)NSString  *screen_name;
@end
