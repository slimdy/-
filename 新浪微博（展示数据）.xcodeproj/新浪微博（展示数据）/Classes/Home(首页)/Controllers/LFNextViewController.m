//
//  LFNextViewController.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/9.
//  Copyright © 2016年 slimdy. All rights reserved.
//
/**
 *  测试用
 *
 *  @param IBAction <#IBAction description#>
 *
 *  @return <#return value description#>
 */
#import "LFNextViewController.h"
#import "LFPopMenuTableViewController.h"
@interface LFNextViewController ()

@end

@implementation LFNextViewController
- (IBAction)next:(id)sender {
    LFPopMenuTableViewController *vc = [[LFPopMenuTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
