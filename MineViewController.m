//
//  MineViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/5.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "MineViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

#import "LoginViewController.h"
#import "SettingViewController.h"

@interface MineViewController () <UIScrollViewDelegate>

@end

@implementation MineViewController

- (void)showUI {
    _loginButton.layer.masksToBounds = YES;
    _loginButton.layer.cornerRadius = 40;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(ScreenSize.width, 740);
}

- (void)addTaskWithUrl:(NSString *)url {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setObject:url forKey:url];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
        
        NSDictionary * dict = responseObject[@"data"];
        //[self.loginButton sd_setBackgroundImageWithURL:[NSURL URLWithString:dict[@"avatar"]] forState:UIControlStateNormal ];
        [_loginButton sd_setBackgroundImageWithURL:[NSURL URLWithString:dict[@"avatar"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"GroupMember_Cell_defaultAvatar.png"]];
        _attentionLabel.text = [NSString stringWithFormat:@"%@关注",dict[@"follow"]];
        _userNameLabel.text = dict[@"username"];
        
        if (_userNameLabel.text == nil) {
            _userNameLabel.text = @"登陆token已过期";
        }
        _fansLabel.text = [NSString stringWithFormat:@"%@粉丝",dict[@"fans"]];
        _footPrintLabel.text = [NSString stringWithFormat:@"%@国家 | %@城市",dict[@"together_country_total"],dict[@"together_city_total"]];
        
        _wantLabel.text = [NSString stringWithFormat:@"%@国家 | %@城市",dict[@"want_counties"],dict[@"want_cities"]];
        
        if (_footPrintLabel.text == nil && _wantLabel.text == nil) {
            _footPrintLabel.text = @"0国家 | 0城市";
            _wantLabel.text = @"0国家 | 0城市";;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
        NSLog(@"%@ : %@",[self class],error);
    }];
}

/*
 data =     {
 avatar = "http://static.qyer.com/images/user2/avatar/big1.png";
 cities = 0;
 countries = 0;
 cover = "http://static.qyer.com/upload/userbg/2b/36/5517284/980";
 fans = 0;
 follow = 0;
 "follow_status" = "\U5173\U6ce8 TA";
 gender = "";
 "im_user_id" = AIM45F59EWCLJ4Z3SJ8GS5B;
 map = "http://open.qyer.com/qyer/user/user_map_photo?user_id=5517284";
 pois = 0;
 title = "\U65b0\U8fdb\U5f1f\U5b50";
 "together_city" = "";
 "together_city_total" = 0;
 "together_country_total" = 0;
 trips = 0;
 "user_id" = 5517284;
 username = qiu90123;
 "want_cities" = 0;
 "want_counties" = 0;
 wants = 0;
 };
 
 */

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _scrollView) {
        CGPoint point = scrollView.contentOffset;
        if (point.y < -15) {
            CGAffineTransform newTransform = CGAffineTransformScale(_userBackImageView.transform, 1.007, 1.007);
            [_userBackImageView setTransform:newTransform];
        } else {
            [UIView animateWithDuration:0.5 animations:^{
                _userBackImageView.frame = CGRectMake(0, 0, ScreenSize.width, 240);
            }];
        }
    }
}

- (void)createNavigationItem {
    UIButton * button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setBackgroundImage:[UIImage imageNamed:@"QYNavSettingWhite"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(settingButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)settingButtonClick:(UIButton *)button {
    SettingViewController * vc = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showUI];
    [self createNavigationItem];
    [self addTitleViewWithTitle:@"我的"];
    [self addTaskWithUrl:@"http://open.qyer.com/qyer/user/profile?app_installtime=1425537023&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=34.78752039928609&lon=113.6651899601235&oauth_token=2cd79b8b2dc51a2a632b21d0e3ee3223&page=1&track_app_channel=App%2520Store&track_app_version=6.1&track_device_info=iPhone%25205s&track_deviceid=36A44E6C-7A4A-457C-94D0-DC0072C3BA28&track_os=ios%25208.1.3&track_user_id=5645756&user_id=5645756&v=1"];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)loginButtobClick:(id)sender {
    LoginViewController * vc = [[LoginViewController alloc] init];
    
    vc.myBlock = ^(BOOL status) {
        if (status) {
            self.userInfoView.hidden = NO;
            NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"];
            NSString * url = [NSString stringWithFormat:LoginSuccess_UserInfo_URL,dict[@"user_id"],dict[@"user_id"],dict[@"access_token"]];
            [self addTaskWithUrl:url finished:@selector(downLoadFinished:)];
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)footPrintButtonClick:(id)sender {

}

- (IBAction)wanteTogoButtonClick:(id)sender {

}

- (IBAction)buttonClick:(id)sender {

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
