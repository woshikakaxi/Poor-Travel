//
//  TravellingViewController.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/5.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "ParentViewController.h"

@interface TravellingViewController : ParentViewController
@property (weak, nonatomic) IBOutlet UIButton *locationButton;

@property (weak, nonatomic) IBOutlet UIButton *city1Button;

@property (weak, nonatomic) IBOutlet UIButton *city2Button;

@property (weak, nonatomic) IBOutlet UIButton *city3Button;
@property (weak, nonatomic) IBOutlet UIButton *city4Button;
@property (weak, nonatomic) IBOutlet UIButton *city5Button;
@property (weak, nonatomic) IBOutlet UIButton *city6Button;
- (IBAction)locationButtonClick:(id)sender;

- (IBAction)cityButtonClick:(id)sender;
@end
