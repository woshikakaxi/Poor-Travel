//
//  SinaSendViewController.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/6.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SinaSendViewController : UIViewController
- (IBAction)sendWeibo:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, copy) NSString * token;
@end
