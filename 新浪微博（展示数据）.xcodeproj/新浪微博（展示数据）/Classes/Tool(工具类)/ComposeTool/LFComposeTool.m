//
//  LFComposeTool.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/16.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFComposeTool.h"
#import "LFRequestComposeTextParamModel.h"
#import "LFRequsetComposeImageParamModel.h"
#import "LFHttpTool.h"

#import "MJExtension.h"
@implementation LFComposeTool
+(void)composeTextUrl:(NSString *)url parameters:(NSString*)weiBo success:(void(^)())success failure:(void(^)(NSError*))failure{
    LFRequestComposeTextParamModel *param = [[LFRequestComposeTextParamModel alloc]init];
    param.status = weiBo;
   
    [LFHttpTool POST:LFComposeTextUrl parameters:param.mj_keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)composeImageWithImage:(UIImage *)image weibo:(NSString *)weibo success:(void(^)())success failure:(void(^)(NSError *error))failure{
    LFRequestComposeTextParamModel *textParam = [[LFRequestComposeTextParamModel alloc]init];
    textParam.status = weibo;
    LFRequsetComposeImageParamModel *imageParam = [[LFRequsetComposeImageParamModel alloc]init];
    imageParam.data = UIImagePNGRepresentation(image);
    NSString *name =[NSString stringWithFormat:@"%d",arc4random() % 100];
    imageParam.name = @"pic";
    imageParam.fileName = name;
    imageParam.mimeType = @"image/png";
    
    [LFHttpTool Upload:LFComposeImageUrl parameters:textParam.mj_keyValues uploadParam:imageParam success:^{
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
