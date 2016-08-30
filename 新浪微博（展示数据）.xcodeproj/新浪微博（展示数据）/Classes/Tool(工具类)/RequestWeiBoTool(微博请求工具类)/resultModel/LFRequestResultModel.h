//
//  LFRequestResultModel.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/11.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface LFRequestResultModel : NSObject<MJKeyValue>
/**
 *  微博的所有数据(LFWeiBoModel)
 */
@property (nonatomic,strong)NSArray *statuses;
@property (nonatomic,assign)int total_number;
@end
