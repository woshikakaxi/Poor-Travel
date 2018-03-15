//
//  UserNameAndSecretCodeViewController.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/6.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserNameAndSecretCodeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
- (IBAction)pressNextStep:(id)sender;

@property (nonatomic, copy) NSString * codeStr;
@property (nonatomic, copy) NSString * phoneNumStr;
@end
