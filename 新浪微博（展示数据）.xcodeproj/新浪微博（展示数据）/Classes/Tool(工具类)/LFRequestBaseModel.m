//
//  LFRequestBaseModel.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/11.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFRequestBaseModel.h"
#import "LFAccountTool.h"
#import "LFAccountModel.h"
@implementation LFRequestBaseModel
//在初始化这个模型时 就讲access——token的值设置好
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.access_token =[LFAccountTool getAccount].access_token;
    }
    return self;
}
@end
