//
//  TrueSinaSendViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/6.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TrueSinaSendViewController.h"
#import "ASIFormDataRequest.h"

@interface TrueSinaSendViewController () <ASIHTTPRequestDelegate>
@property (nonatomic, copy) NSString * token;
@end

@implementation TrueSinaSendViewController

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

- (IBAction)sendWeibo:(id)sender {
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/2/statuses/update.json"]];
    request.delegate = self;
    [request setPostValue:self.token forKey:@"access_token"];
    [request setPostValue:_textView.text forKey:@"status"];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"%@", request.responseString);
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"发送失败");
}

- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    self.token = [userDefaults objectForKey:@"token"];
}


@end
