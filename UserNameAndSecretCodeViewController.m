//
//  UserNameAndSecretCodeViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/6.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "UserNameAndSecretCodeViewController.h"
#import "AFNetworking.h"
#import "MineViewController.h"

@interface UserNameAndSecretCodeViewController () {
    UILabel * _label;
    NSMutableDictionary * _dict;
}

@end

@implementation UserNameAndSecretCodeViewController

- (void)createTipLabel {
    _label = [[UILabel alloc] initWithFrame:CGRectMake((ScreenSize.width - 200)/2, 255, 200, 40)];
    _label.font = [UIFont systemFontOfSize:13];
    _label.textColor = [UIColor whiteColor];
    _label.layer.masksToBounds = YES;
    _label.layer.cornerRadius = 20;
    _label.backgroundColor = [UIColor lightGrayColor];
    _label.hidden = YES;
    _label.alpha = 1;
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_codeText resignFirstResponder];
    [_userNameText resignFirstResponder];
}

- (void)labelAnimate {
    _label.hidden = NO;
    _label.text = _dict[@"info"];
    [UIView animateWithDuration:4 animations:^{
        _label.alpha = 0;
    } completion:^(BOOL finished) {
        [self createTipLabel];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dict = [[NSMutableDictionary alloc] init];
    _codeText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self createTipLabel];
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

- (IBAction)pressNextStep:(id)sender {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://open.qyer.com/qyer/user/signup?account_s=0f3fd7f1b2302be02b2d8aff194cb803&account_type=2&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&code=%@&mobile=%@&password=%@&username=%@",_codeStr,_phoneNumStr,_codeText.text,_userNameText.text] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _dict = responseObject;
        if ([_dict[@"info"] isEqualToString:@""]) {
            _label.text = @"注册成功";
            _label.hidden = NO;
            [UIView animateWithDuration:3 animations:^{
                _label.alpha = 0;
            } completion:^(BOOL finished) {
                [_label removeFromSuperview];
                MineViewController * vc = [[MineViewController alloc] init];
               // vc.url = @"http://open.qyer.com/qyer/user/profile?app_installtime=1425537023&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=34.78752039928609&lon=113.6651899601235&oauth_token=2cd79b8b2dc51a2a632b21d0e3ee3223&page=1&track_app_channel=App%2520Store&track_app_version=6.1&track_device_info=iPhone%25205s&track_deviceid=36A44E6C-7A4A-457C-94D0-DC0072C3BA28&track_os=ios%25208.1.3&track_user_id=5645756&user_id=5645756&v=1";
                [self.navigationController pushViewController:vc animated:YES];
            }];
        } else {
            [self labelAnimate];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
@end
