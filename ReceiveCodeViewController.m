//
//  ReceiveCodeViewController.m
//  Poor Travel
//
//  Created by qianfeng on 15/3/5.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "ReceiveCodeViewController.h"
#import "AFNetworking.h"
#import "UserNameAndSecretCodeViewController.h"

@interface ReceiveCodeViewController () {
    BOOL _isOutTime;
    NSTimer * _timer;
    int time;
    
    UILabel * _label;
}

@end

@implementation ReceiveCodeViewController

- (void)createTipLabel {
    _label = [[UILabel alloc] initWithFrame:CGRectMake((ScreenSize.width - 200)/2, 240, 200, 40)];
    _label.font = [UIFont systemFontOfSize:13];
    _label.textColor = [UIColor whiteColor];
    _label.layer.masksToBounds = YES;
    _label.layer.cornerRadius = 20;
    _label.numberOfLines = 0;
    _label.backgroundColor = [UIColor lightGrayColor];
    _label.hidden = YES;
    _label.alpha = 1;
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTipLabel];
    time = 60;
    _infoLabel.text = [NSString stringWithFormat:@"验证信息已发送至%@",_phoneNumStr];
    [self createTimer];
}

- (void)createTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTimer) userInfo:nil repeats:YES];
}

- (void)changeTimer {
    time--;
    _timeLabel.text = [NSString stringWithFormat:@"%d",time];
    _senderButton.enabled = NO;
    if (time == 0) {
        _timeLabel.hidden = YES;
        _kuohaoLabel.hidden = YES;
        _senderButton.enabled = YES;
        [_timer invalidate];
        time = 60;
        _timeLabel.text = [NSString stringWithFormat:@"%d",time];
    }
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

- (IBAction)sendAgain:(id)sender {

    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://open.qyer.com/qyer/user/active_code?&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&country_code=86&mobile=%@",_phoneNumStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"验证码发送成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
    _kuohaoLabel.hidden = NO;
    _timeLabel.hidden = NO;
    [self createTimer];
    
}

- (IBAction)pressNextStep:(id)sender {
    if ([_codeTextField.text isEqualToString:_codeStr]) {
        UserNameAndSecretCodeViewController * vc = [[UserNameAndSecretCodeViewController alloc] init];
        vc.codeStr = _codeTextField.text;
        vc.phoneNumStr = [NSString stringWithFormat:@"86-%@",_phoneNumStr];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        _label.text = @"验证码输入错误";
        _label.hidden = NO;
        [UIView animateWithDuration:4 animations:^{
            _label.alpha = 0;
        } completion:^(BOOL finished) {
            [self createTipLabel];
        }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_codeTextField resignFirstResponder];
}
@end
