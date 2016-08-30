//
//  LFWeiBoModel.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/10.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFUserModel.h"
#import "MJExtension.h"
@interface LFWeiBoModel : NSObject<MJKeyValue>

/**
 *  微博内容
 */
@property (nonatomic,copy)NSString *text;
/**
 *  微博来源
 */
@property (nonatomic,copy)NSString *source;
/**
 *  字符串型id
 */
@property (nonatomic,copy)NSString *idstr;
/**
 *  微博创建时间
 */
@property (nonatomic,copy)NSString *created_at;
/**
 *  转发数
 */
@property (nonatomic,assign)int reposts_count;
/**
 *  评论数
 */
@property (nonatomic,assign)int comments_count;
/**
 *  表态数（赞）
 */
@property (nonatomic,assign)int attitudes_count;
/**
 *  配图数组
 */
@property (nonatomic,strong)NSArray *pic_urls;
/**
 *  用户
 */
@property (nonatomic,strong) LFUserModel *user;
/**
 *  转发微博
 */
@property (nonatomic, strong) LFWeiBoModel *retweeted_status;
/**
 *  转发微博人的名称
 */
@property (nonatomic,copy) NSString *retweetedName;
@end
