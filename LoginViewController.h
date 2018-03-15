//
//  LoginViewController.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/5.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^StatusBlock)(BOOL userInfo);

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UIButton *regestButton;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *weiBoLogin;

@property (weak, nonatomic) IBOutlet UIButton *weiXinLoginButton;

@property (copy,nonatomic) StatusBlock myBlock;


- (IBAction)cancleButtonClick:(id)sender;

- (IBAction)regestButtonClick:(id)sender;

- (IBAction)loginButtonClick:(id)sender;

- (IBAction)UMLoginClick:(id)sender;
@end
