//
//  LFWeiBoModel.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/10.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFWeiBoModel.h"
#import "LFPhotoModel.h"
#import "NSDate+MJ.h"
@implementation LFWeiBoModel
/**
 *  mj框架里的协议，用来字典转模型的
 *
 *  @return <#return value description#>
 */
+(NSDictionary *)mj_objectClassInArray{
    return @{@"pic_urls":[LFPhotoModel class]};
}
/**
 *  在得到新浪数据里的时间后，将它做一些处理，
 *
 *  @return
 */
-(NSString *)created_at{
    //分析：先判断是今年还是去年 如果是去年则显示 2015-08-13 15：17 yyyy-MM-dd HH:mm
    //     如果是今天 则要分情况，昨天则显示 昨天 HH:mm 两天前 MM-dd HH:mm
    //     今天又要分情况 1min>time>1s 刚刚  1h>time>1min mm分钟前  1day>time>1h HH小时前
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *created_at = [fmt dateFromString:_created_at];
    if ([created_at isThisYear]) {//是今年
        if ([created_at isToday]) {
            NSDateComponents *cmp = [created_at deltaWithNow];
            //LFLog(@"%ld--%ld--%ld",cmp.hour,cmp.minute,cmp.second);
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",cmp.hour];
            }else if(cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟前",cmp.minute];
            }else{
                return @"刚刚";
            }
            
        }else if ([created_at isYesterday]){
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:created_at];
        }else{//两天前
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:created_at];
        }
        
        
    }else{//非今年
        fmt.dateFormat =@"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:created_at];
    }
    return _created_at;
}
/**
 *  重写retweeted_statu方法，用来生成retweetName  因为在给被转发微博的博主名称不好加“@” 也就意味着要加@ 原创和转发都会加，为了以示区别，只有有转发微博 才会来到转发微博的set方法，在set方法里面给retweetName赋值
 */
-(void)setRetweeted_status:(LFWeiBoModel *)retweeted_status{
    _retweeted_status = retweeted_status;
    _retweetedName = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
}
@end
