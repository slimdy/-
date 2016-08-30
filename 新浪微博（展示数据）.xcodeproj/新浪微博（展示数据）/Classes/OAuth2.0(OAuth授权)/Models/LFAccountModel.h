//
//  LFAccountModel.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/10.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFAccountModel : NSObject<NSCoding>//因为我们要将本对象归档，所以需要他遵守nscoding协议
/**
 * access_toke
 */
@property (nonatomic,copy)NSString *access_token;
/**
 *  过期的总时间
 */
@property (nonatomic,copy)NSString *expires_in;
/**
 *  已废弃，但是为了KVC 能够赋值，保持结构完整
 */
@property (nonatomic,copy)NSString *remind_in;
/**
 *  用户的唯一标示
 */
@property (nonatomic,copy)NSString *uid;
/**
 *  过期到什么时候
 */
@property (nonatomic,strong)NSDate *expires_date;
/**
 *  用户名称 在获得用户的微博信息时赋值
 */
@property (nonatomic,copy)NSString *name;
/**
 *  初始化对象方法，KVC
 *
 *  @param dic 数据字典
 *
 *  @return
 */
-(instancetype)initWithDic:(NSDictionary *)dic;
/**
 *  初始化类方法
 *
 *  @param dic 数据字典
 *
 *  @return
 */
+(instancetype)createAccountWith:(NSDictionary *)dic;
@end
