//
//  LFUserTool.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/11.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFUserTool.h"
#import "LFHttpTool.h"
#import "LFAccountTool.h"
#import "LFAccountModel.h"
#import "LFRequsetUnreadParamModel.h"
#import "LFRequestUserInfoParamModel.h"

#import "MJExtension.h"
@implementation LFUserTool
+(void)getUnreadWithSuccess:(void(^)(LFRequestUnreadResultModel *resultModel))success failure:(void(^)(NSError *error))failure{
    //设置参数模型
    LFRequsetUnreadParamModel *param = [[LFRequsetUnreadParamModel alloc]init];
    param.uid = [LFAccountTool getAccount].uid;
    //发送get请求
    [LFHttpTool GET:LFUreadUrl parameters:param.mj_keyValues success:^(id responseObject) {
        //成功后将返回字典数据转成结果模型
        LFRequestUnreadResultModel *resultModel = [LFRequestUnreadResultModel mj_objectWithKeyValues:responseObject];
        //如果外界有成功后要做的事则执行外界的block
        if (success) {
            success(resultModel);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)getUserinfoWithSuccess:(void(^)(LFRequestUserInfoResultModel *resultModel))success failure:(void(^)(NSError *error))failure{
    //设置参数模型
    LFRequestUserInfoParamModel *param = [[LFRequestUserInfoParamModel alloc]init];
    param.uid = [LFAccountTool getAccount].uid;
    //发送get请求
    [LFHttpTool GET:LFUserInfoUrl parameters:param.mj_keyValues success:^(id responseObject) {
        //成功后将返回字典数据转成结果模型
        LFRequestUserInfoResultModel *resultModel = [LFRequestUserInfoResultModel mj_objectWithKeyValues:responseObject];
        //如果外界有成功后要做的事则执行外界的block
        if (success) {
            success(resultModel);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
