//
//  LFAccountTool.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/10.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFAccountTool.h"
#import "LFAccountModel.h"
#import "LFHttpTool.h"
#import "LFATRequestParamModel.h"

#import "MJExtension.h"
#define LFArchivePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingPathComponent:@"account.data"]
@implementation LFAccountTool
static LFAccountModel *_account;
/**
 *  归档存储到document里面
 *
 *  @param account <#account description#>
 */
+(void)saveAccountWithAccount:(LFAccountModel *)account{

    [NSKeyedArchiver archiveRootObject:account toFile:LFArchivePath];
    
}
/**
 *  取出账户信息
 *
 *  @return 账户信息
 */
+(LFAccountModel *)getAccount{
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:LFArchivePath];
        if ([[NSDate date] compare: _account.expires_date] != NSOrderedAscending) {//过期了
            return nil;
        }
    }
    return _account;
}

+(void)getAccessTokenWith:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure{
    //设置请求参数模型
    LFATRequestParamModel *paramModel = [[LFATRequestParamModel alloc]init];
    paramModel.client_id = LFAppKey;
    paramModel.client_secret = LFAppSecret;
    paramModel.grant_type = @"authorization_code";
    paramModel.code = code;
    paramModel.redirect_uri = LFRedirectUrl;
    //发送post请求
    [LFHttpTool POST:LFAccessTokenUrl parameters:paramModel.mj_keyValues success:^(id responseObject) {
        //获得accesstoken 将它归档
        LFAccountModel *account = [LFAccountModel createAccountWith:responseObject];
        [LFAccountTool  saveAccountWithAccount:account];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
