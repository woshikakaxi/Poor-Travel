//
//  SinaViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/6.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "SinaViewController.h"
#import "AFNetworking.h"
#import "SinaSendViewController.h"

@interface SinaViewController () <UIWebViewDelegate> {
    UIWebView * _webView;
}

@end

@implementation SinaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebView];
}

- (void)createWebView {
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2967579997&redirect_uri=http://www.qyer.com&response_type=code"]];
    _webView.delegate = self;
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@",request.URL.absoluteString);
    //分割字符串  回调地址？code=认证token
    NSArray * arr = [request.URL.absoluteString componentsSeparatedByString:@"?code="];
    if (arr.count == 2) {
        //请求第二个接口  获取访问token
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        NSDictionary * parameters = @{@"client_id":@"2967579997",
                                @"client_secret":@"b4e8470089c023f02ab41ea05d765628",
                                      
                                    @"grant_type":@"authorization_code",
                                      
                                    @"code":arr[1],
                                      
                                    @"redirect_uri":@"http://www.qyer.com"};
        [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //获取数据
            NSDictionary * dict = responseObject;
            NSLog(@"++++%@",responseObject);
            NSString * token = dict[@"access_token"];

            SinaSendViewController * sina = [[SinaSendViewController alloc] init];
            sina.token = token;
            [self.navigationController pushViewController:sina animated:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"授权失败 ： %@",error);
        }];
        return NO;
    }
    return YES;
}

- (void)requestData {
    
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
