//
//  CityHeaderView.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *guideButton;

@property (weak, nonatomic) IBOutlet UIButton *tipsButton;
@property (weak, nonatomic) IBOutlet UIButton *smguideButton;
@property (weak, nonatomic) IBOutlet UIButton *planButton;

@property (weak, nonatomic) IBOutlet UIButton *sceneryButton;
@property (weak, nonatomic) IBOutlet UIButton *foodButton;
@property (weak, nonatomic) IBOutlet UIButton *shoppingButton;

@property (weak, nonatomic) IBOutlet UIButton *asumentButton;

@property (weak, nonatomic) IBOutlet UILabel *tripsLabel;

@property (weak, nonatomic) IBOutlet UIButton *lookMoreButton;
@end
