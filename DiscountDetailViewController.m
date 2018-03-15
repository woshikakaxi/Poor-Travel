//
//  DiscountDetailViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "DiscountDetailViewController.h"

@interface DiscountDetailViewController ()

@end

@implementation DiscountDetailViewController

- (void)createWebView:(NSString *)url {
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - 49 - 64)];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    NSString * url = [NSString stringWithFormat:Discount_Detail_URL,self.discountID];
    [self createWebView:url];
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
