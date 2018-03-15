//
//  TravelingCityViewController.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/5.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelingCityViewController : UIViewController

@property (nonatomic, copy) NSString * lat;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel_en;
@property (weak, nonatomic) IBOutlet UIScrollView *chatScrollView;
@property (weak, nonatomic) IBOutlet UIButton *smGuideButton;
@property (weak, nonatomic) IBOutlet UIButton *poiButton;
@property (weak, nonatomic) IBOutlet UIButton *footButton;

@property (weak, nonatomic) IBOutlet UIButton *activityButton;

@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;

@property (weak, nonatomic) IBOutlet UILabel *chatRoomLabel;


@property (weak, nonatomic) IBOutlet UIView *chatView;
@end
