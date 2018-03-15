//
//  RegisterViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/5.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFNetworking.h"
#import "ReceiveCodeViewController.h"

@interface RegisterViewController () {
    NSMutableDictionary * _dict;
    UILabel * _label;
}

@end

@implementation RegisterViewController

- (void)addTaskWithUrl:(NSString *)url {
    
}

- (void)createTipLabel {
    _label = [[UILabel alloc] initWithFrame:CGRectMake((ScreenSize.width - 200)/2, 290, 200, 40)];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _dict = [[NSMutableDictionary alloc] init];
    [self createTipLabel];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
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

- (IBAction)pressToReceiveCode:(id)sender {
//    [self addTaskWithUrl:[NSString stringWithFormat:@"http://open.qyer.com/qyer/user/active_code?&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&country_code=86&mobile=%@",_textField.text]];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://open.qyer.com/qyer/user/active_code?&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&country_code=86&mobile=%@",_textField.text] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //_dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];
        _dict = responseObject;
        
        if (![_dict[@"info"] isEqualToString:@""]) {
            [self labelAnimate];
        } else {
            _label.hidden = NO;
            _label.text = @"注意收取验证码";
            [UIView animateWithDuration:3 animations:^{
                _label.alpha = 0;
            } completion:^(BOOL finished) {
                ReceiveCodeViewController * vc = [[ReceiveCodeViewController alloc] init];
                vc.phoneNumStr = _textField.text;
                vc.codeStr = _dict[@"data"][@"code"];
                [self.navigationController pushViewController:vc animated:YES];
                [_label removeFromSuperview];
            }];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@ : %@",[self class],error);
    }];
    
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

@end
