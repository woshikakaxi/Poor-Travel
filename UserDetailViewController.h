//
//  UserDetailViewController.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/3.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailViewController : UIViewController
@property (nonatomic,copy) NSString *userID;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *userBackImageView;
@property (weak, nonatomic) IBOutlet UIButton *userHeaderButton;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;
@property (weak, nonatomic) IBOutlet UIButton *footPrintButton;
@property (weak, nonatomic) IBOutlet UIButton *wantTogoButton;

@property (weak, nonatomic) IBOutlet UIButton *userInviButton;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@property (weak, nonatomic) IBOutlet UILabel *footPrintLbael;
@property (weak, nonatomic) IBOutlet UILabel *wantLabel;
@property (weak, nonatomic) IBOutlet UIButton *userFootPrintButton;


@property (weak, nonatomic) IBOutlet UIImageView *togetherImageView;

@property (weak, nonatomic) IBOutlet UILabel *togetherLabel;
@end
