//
//  LFWeiBoCacheTool.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/17.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFWeiBoCacheTool.h"
#import "LFAccountTool.h"
#import "LFAccountModel.h"
#import "LFRequestParamModel.h"
#import "LFWeiBoModel.h"

#import "FMDB.h"
@implementation LFWeiBoCacheTool
static FMDatabase *_DB;
+(void)initialize{
    NSString *filePath = LFDBCachePath;
    _DB = [FMDatabase databaseWithPath:filePath];
    if ([_DB open]) {
        LFLog(@"打开数据库成功");
    }else{
        LFLog(@"打开数据库失败");
    }
  BOOL flag = [_DB executeUpdate:@"create table if not exists lf_weibos (id integer primary key autoincrement,idstr text, access_token text,weibo blob);"];
    if (flag) {
        LFLog(@"表创建成功");
    }else{
        LFLog(@"表创建失败");
    }
}
+(void)saveWeiboWith:(NSArray *)weibos{
    for (NSDictionary *dic in weibos) {
        NSString *idstr = dic[@"idstr"];
        NSString *access_token =[LFAccountTool getAccount].access_token;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
       BOOL flag = [_DB executeUpdate:@"insert into lf_weibos (idstr,access_token,weibo) values (?,?,?);",idstr,access_token,data];
        if (flag ) {
            LFLog(@"插入成功");
        }else{
            LFLog(@"插入失败");
        }
        
    }
}
+(NSArray *)getWeiboInDBWith:(LFRequestParamModel *)param{
    //进入程序第一次查询数据 20条
    NSString *sql = [NSString stringWithFormat:@"select * from lf_weibos where access_token = '%@' order by idstr DESC limit 20;",param.access_token];
    if (param.since_id) {
        sql = [NSString stringWithFormat:@"select * from lf_weibos where access_token = '%@' and idstr > '%@' order by idstr limit 20;",param.access_token,param.since_id];
    }else if(param.max_id){
        sql = [NSString stringWithFormat:@"select * from lf_weibos where access_token = '%@' and idstr < '%@' order by idstr limit 20;",param.access_token,param.max_id];
    }
    
    FMResultSet *result = [_DB executeQuery:sql];
    NSMutableArray *weibos = [NSMutableArray array];
    while ([result next]) {
        NSData * data = [result dataForColumn:@"weibo"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        LFWeiBoModel *weibo = [LFWeiBoModel mj_objectWithKeyValues:dict];
        [weibos addObject:weibo];
    }
    return weibos;
}
@end
