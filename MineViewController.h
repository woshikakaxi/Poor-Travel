//
//  MineViewController.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/5.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "ParentViewController.h"

@interface MineViewController : ParentViewController
@property (weak, nonatomic) IBOutlet UIImageView *userBackImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginButtobClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;

@property (weak, nonatomic) IBOutlet UIButton *footPrintButton;

@property (weak, nonatomic) IBOutlet UIButton *wanteTogoButton;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansLabel;

@property (weak, nonatomic) IBOutlet UILabel *footPrintLabel;

@property (weak, nonatomic) IBOutlet UILabel *wantLabel;

@property (weak, nonatomic) IBOutlet UIView *userInfoView;

@property (nonatomic, copy) NSString * yanzhengmaStr;
@property (nonatomic, copy) NSString * userNameStr;
@property (nonatomic, copy) NSString * secretCodeStr;

//登陆网址
@property (nonatomic, copy) NSString * url;

- (IBAction)footPrintButtonClick:(id)sender;
- (IBAction)wanteTogoButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *myGuideButton;

@property (weak, nonatomic) IBOutlet UIButton *myDiscountButton;

@property (weak, nonatomic) IBOutlet UIButton *myPlanButton;

@property (weak, nonatomic) IBOutlet UIButton *myInvitationButton;

- (IBAction)buttonClick:(id)sender;
@end
