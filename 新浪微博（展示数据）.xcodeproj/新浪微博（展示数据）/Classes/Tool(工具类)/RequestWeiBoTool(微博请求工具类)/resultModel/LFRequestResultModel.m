//
//  LFRequestResultModel.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/11.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFRequestResultModel.h"
#import "LFWeiBoModel.h"
@implementation LFRequestResultModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"statuses":[LFWeiBoModel class]};
}
@end
