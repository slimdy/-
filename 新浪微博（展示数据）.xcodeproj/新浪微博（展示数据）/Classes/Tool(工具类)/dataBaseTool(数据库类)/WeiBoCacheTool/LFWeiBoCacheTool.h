//
//  LFWeiBoCacheTool.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/17.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LFRequestParamModel;
@interface LFWeiBoCacheTool : NSObject
+(void)saveWeiboWith:(NSArray *)weibos;
+(NSArray *)getWeiboInDBWith:(LFRequestParamModel *)param;
@end
