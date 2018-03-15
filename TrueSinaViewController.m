//
//  TrueSinaViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/6.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TrueSinaViewController.h"
#import "ASIFormDataRequest.h"
#import "TrueSinaSendViewController.h"

@interface TrueSinaViewController () <UIWebViewDelegate, ASIHTTPRequestDelegate>{
    UIWebView* _webView;
}


@end

@implementation TrueSinaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL* url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2967579997&redirect_uri=http://www.qyer.com&response_type=code"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    //第一个请求,获取认证token
    [_webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%@", request.URL.absoluteString);
    //分割字符串 回调地址?code=认证token
    NSArray* array = [request.URL.absoluteString componentsSeparatedByString:@"?code="];
    if (array.count == 2) {
        //请求第二个接口，获取访问token
        ASIFormDataRequest* asiRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/access_token"]];
        asiRequest.delegate = self;
        [asiRequest setPostValue:@"2967579997" forKey:@"client_id"];
        [asiRequest setPostValue:@"b4e8470089c023f02ab41ea05d765628" forKey:@"client_secret"];
        [asiRequest setPostValue:@"authorization_code" forKey:@"grant_type"];
        [asiRequest setPostValue:array[1] forKey:@"code"];
        [asiRequest setPostValue:@"http://www.qyer.com" forKey:@"redirect_uri"];
        [asiRequest startAsynchronous];
        return NO;
    }
    return YES;
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
    NSString* token = dic[@"access_token"];
    //保存token
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:@"token"];
    [userDefaults synchronize];
    
    //跳转
    TrueSinaSendViewController * send = [[TrueSinaSendViewController alloc] init];
    [self.navigationController pushViewController:send animated:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"登陆失败");
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
