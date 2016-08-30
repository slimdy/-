//
//  LFSettingViewController.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/17.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFSettingViewController.h"
#import "SDImageCache.h"
@interface LFSettingViewController ()

@end

@implementation LFSettingViewController
static NSString *ID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //tableview也可以注册cell 如果不注册，就得在返回cell的方法里自己创建，storyboard 加载的时候也是注册了cell
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    NSString *filePath = LFDBCachePath;
    NSFileManager* manager = [NSFileManager defaultManager];
    NSInteger cacheFileSize = 0;
    if ([manager fileExistsAtPath:filePath]){
          cacheFileSize= [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }

    cell.textLabel.text = @"清除缓存";
    NSUInteger size = [SDImageCache sharedImageCache].getSize + cacheFileSize;
    NSString *cache = nil;
    //size 单位是B
    if (size > 1024*1024 *1024) {
        float floatSize = size / 1024.0/1024.0/1024.0;
        cache = [NSString stringWithFormat:@"%.1fG",floatSize];
    }else if(size > 1024 *1024){
        float floatSize = size / 1024.0/1024.0;
        cache = [NSString stringWithFormat:@"%.1fM",floatSize];
    }else if (size > 1024){
        float floatSize = size /1024.0;
        cache = [NSString stringWithFormat:@"%.1fKB",floatSize];
    }else{
        cache =nil;
    }
        
    cell.detailTextLabel.text = cache;;
   
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[SDImageCache sharedImageCache] clearDisk];
    [self clearDB];
    [self.tableView reloadData];
}

-(void)clearDB{
    NSString *filePath = LFDBCachePath;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error;
    [manager removeItemAtPath:filePath error:&error];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
