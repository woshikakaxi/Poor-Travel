//
//  ReceiveCodeViewController.h
//  Poor Travel
//
//  Created by qianfeng on 15/3/5.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiveCodeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *senderButton;
@property (weak, nonatomic) IBOutlet UILabel *kuohaoLabel;
- (IBAction)sendAgain:(id)sender;
- (IBAction)pressNextStep:(id)sender;

@property (nonatomic,copy) NSString * phoneNumStr;
@property (nonatomic, copy) NSString * codeStr;
@end
