//
//  SinaSendViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/6.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "SinaSendViewController.h"
#import "AFNetworking.h"

@interface SinaSendViewController ()

@end

@implementation SinaSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _button.clipsToBounds = YES;
    _button.layer.cornerRadius = 21;
    
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
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    NSDictionary * dict = @{@"access_token":_token,@"status":_textView.text};
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"微博分享失败 ： %@",error);
    }];
    
}
@end
