//
//  LFOAuthViewController.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/10.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFOAuthViewController.h"
#import "LFAccountModel.h"
#import "LFAccountTool.h"
#import "LFRootViewControllerTool.h"

#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
@interface LFOAuthViewController ()<UIWebViewDelegate>

@end
/**
 * 这个控制器是用来新浪OAUth 授权的
 */
@implementation LFOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //显示一个和屏幕一样大的webView
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    //授权地址拼接
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",LFOAuthBaseUrl,LFAppKey,LFRedirectUrl];
    NSURL *url = [NSURL URLWithString:urlStr];
    //求请求授权
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
}
#pragma mark -<UIWebView的代理>-- 已经开始加载时调用
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载..."];
}
#pragma mark -<UIWebView的代理>-- 结束加载时调用
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}
#pragma mark -<UIWebView的代理>-- 加载失败是调用
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}
#pragma mark -<UIWebView的代理>-- 在开始加载页面之前条用 返回yes 则是展示页面，返回no时不显示
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //获得返回的url code= 所在的返回
    NSRange range = [request.URL.absoluteString rangeOfString:@"code="];
//    LFLog(@"%@",NSStringFromRange(range));
    //如果code= 存在，也就是说返回的是需要的回调页面
    if (range.length) {
        //截取字符串
        NSString *code = [request.URL.absoluteString substringFromIndex:range.location+range.length ];
        //换取accessToken
        [self getAccessTokenWithCode:code];
        //不显示页面
        return  NO;
    }
    return YES;
}
/**
 *  获取accesstoken 如果获取成功则选择根控制器
 *
 *  @param code 获得code
 */

-(void)getAccessTokenWithCode:(NSString *)code{
    [LFAccountTool getAccessTokenWith:code success:^{
        [LFRootViewControllerTool chooseRootViewControllerWithWindow:LFKeyWindow];
    } failure:^(NSError *error) {
        if (error) {
            LFLog(@"%@",error);
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
