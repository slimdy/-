//
//  LFAccountModel.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/10.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFAccountModel.h"
//定义宏 把数据归档定义的key
#define AccessTokenKey @"access_token"
#define UidKey @"uid"
#define Expires_inKey @"expires_in"
#define Expires_DateKey @"expires_date"
#define UserScreen_name @"screen_name"
@implementation LFAccountModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
/**
 *  在设置过期总时间的时候，设置过期到什么时候
 *
 *  @param expires_in <#expires_in description#>
 */
-(void)setExpires_in:(NSString *)expires_in{
    _expires_in = expires_in;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
    _expires_date = date;
}
/**
 *  nscoding 协议 解档的时候使用  可以使用MJExtension 的方法 代替，这里就不用了
 *
 *  @param aCoder
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:AccessTokenKey];
    [aCoder encodeObject:self.uid forKey:UidKey];
    [aCoder encodeObject:self.expires_in forKey:Expires_inKey];
    [aCoder encodeObject:self.expires_date forKey:Expires_DateKey];
    [aCoder encodeObject:self.name forKey:UserScreen_name];
}
/**
 *  nscoding 协议 归档的时候使用  可以使用MJExtension 的方法 代替，这里就不用了
 *
 *  @param aCoder
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.access_token =  [aDecoder decodeObjectForKey:AccessTokenKey];
        self.uid =  [aDecoder decodeObjectForKey:UidKey];
        self.expires_in =  [aDecoder decodeObjectForKey:Expires_inKey];
        self.expires_date =  [aDecoder decodeObjectForKey:Expires_DateKey];
        self.name = [aDecoder decodeObjectForKey:UserScreen_name];
    }
    return self;
}
+(instancetype)createAccountWith:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}
@end
