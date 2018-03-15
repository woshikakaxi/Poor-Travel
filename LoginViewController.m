//
//  LoginViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/5.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "RegisterViewController.h"
#import "SinaViewController.h"
#import "TrueSinaViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

//client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786497&lon=113.671518&username=18510421092&password=633257&account_s=df920e2287329dc8825912a13b4a2c12&grant_type=password&account_type=1


//client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786493&lon=113.671522&username=qiu90123&password=633257&account_s=5721753b29cc9fc8d521141db9e39434&grant_type=password&account_type=1

- (void)loginPost:(NSString *)url account:(NSString *)account password:(NSString *)password {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"client_id":@"qyer_android",@"client_secret":@"9fcaae8aefc4f9ac4915",@"v":@"1",@"track_deviceid":@"357474045959836",@"track_app_version":@"6.0",@"track_app_channel":@"360m",@"track_device_info":@"GT-I9100",@"track_os":@"Android4.1.2",@"track_user_id":@"",@"app_installtime":@"1422450627633",@"username":account ,@"password":password,@"account_s":@"5721753b29cc9fc8d521141db9e39434",@"grant_type":@"password",@"account_type":@"1"};
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = responseObject[@"data"];
        //NSString *str = dict[@"access_token"];
        
        /*
         data =     {
         "access_token" = 4fc94e2b8219c419b7b38d2673048eae;
         avatar = "http://static.qyer.com/images/user2/avatar/big1.png";
         cover = "http://static.qyer.com/upload/userbg/2b/36/5517284/980";
         "expires_in" = 3153600000;
         gender = 0;
         "im_user_id" = AIM45F59EWCLJ4Z3SJ8GS5B;
         map = "http://open.qyer.com/qyer/user/user_map_photo?user_id=5517284";
         scope = "<null>";
         title = "\U65b0\U8fdb\U5f1f\U5b50";
         "user_id" = 5517284;
         username = qiu90123;
         */
        NSDictionary * saveDataDict = @{@"access_token":dict[@"access_token"],@"expires_in":dict[@"expires_in"],@"im_user_id":dict[@"im_user_id"],@"user_id":dict[@"user_id"],@"username":dict[@"username"]};
        [[NSUserDefaults standardUserDefaults] setObject:saveDataDict forKey:@"loginData"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if ([[responseObject[@"status"] stringValue] isEqualToString:@"1"]) {
            NSLog(@"登陆成功！");
            
            BOOL status = YES;
            @try {
                if (self.myBlock) {
                    self.myBlock(status);
                }
            }
            @catch (NSException *exception) {
                NSLog(@"%@",exception);
            }
            @finally {
                
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@ : %@",[self class],error);
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.accountTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)cancleButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)regestButtonClick:(id)sender {
    RegisterViewController * vc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginButtonClick:(id)sender {
    [self loginPost:Login_URL account:self.accountTextField.text password:self.passwordTextField.text];
}

- (IBAction)UMLoginClick:(id)sender {
    UIButton * btn = (UIButton *)sender;
    if (btn.tag == 1) {
        //新浪分享
//        SinaViewController * sina = [[SinaViewController alloc] init];
//        [self.navigationController pushViewController:sina animated:YES];
        TrueSinaViewController * sina = [[TrueSinaViewController alloc] init];
        [self.navigationController pushViewController:sina animated:YES];
        
    } else {
        //微博分享
        
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

@end
