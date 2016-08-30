//
//  LFRequestWeiBoTool.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/11.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFRequestWeiBoTool.h"
#import "LFHttpTool.h"
#import "LFRequestResultModel.h"
#import "LFRequestParamModel.h"
#import "LFWeiBoCacheTool.h"
@implementation LFRequestWeiBoTool

+(void)requestNewWeiBoWithSinceId:(NSString *)since_id success:(void(^)(NSArray *responseArr))success failure:(void(^)(NSError *error))failure{
    //设置参数模型
    LFRequestParamModel *paramModel = [[LFRequestParamModel alloc]init];
    if (since_id) {
        paramModel.since_id = since_id;
    }
    //先在数据库中查询有无数据，有的话直接返回，没有的话在向服务器请求
    NSArray *dataArr = [LFWeiBoCacheTool getWeiboInDBWith:paramModel];
    if (dataArr.count) {
        if (success) {
            success(dataArr);
        }
        return;
    }
    //发送get请求
        [LFHttpTool GET:LFWBGetNewWeiBoUrl parameters:paramModel.mj_keyValues success:^(id responseObject) {
            //如果成功则转换字典数组到结果模型
        LFRequestResultModel *resultModel = [LFRequestResultModel mj_objectWithKeyValues:responseObject];
           //如果外面有回调 则执行
            if (success) {
                success(resultModel.statuses);
            }
            //存入数据库
            [LFWeiBoCacheTool saveWeiboWith:responseObject[@"statuses"]];
            
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)requestNewWeiBoWithMaxId:(NSString *)max_id success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    //设置参数模型
    LFRequestParamModel *paramModel = [[LFRequestParamModel alloc]init];
    if (max_id) {
        paramModel.max_id = max_id;
    }
    //现在数据库中查询有无数据，有的话直接返回，没有的话在向服务器请求
    NSArray *dataArr = [LFWeiBoCacheTool getWeiboInDBWith:paramModel];
    if (dataArr.count) {
        if (success) {
            success(dataArr);
        }
        return;
    }
    //发送get请求
    [LFHttpTool GET:LFWBGetNewWeiBoUrl parameters:paramModel.mj_keyValues success:^(id responseObject){
       //如果成功则转换字典数组到结果模型
        LFRequestResultModel *resultModel = [LFRequestResultModel mj_objectWithKeyValues:responseObject];
        //如果外面有回调 则执行
        if (success) {
            success(resultModel.statuses);
        }
        //存入数据库
        [LFWeiBoCacheTool saveWeiboWith:responseObject[@"statuses"]];
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
