//
//  DestionDetailHeaderView.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestionDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIButton *guideButton;
@property (weak, nonatomic) IBOutlet UIButton *tipsButton;
@property (weak, nonatomic) IBOutlet UIButton *smGuideButton;
@property (weak, nonatomic) IBOutlet UIButton *planButton;


@property (weak, nonatomic) IBOutlet UIView *cityView;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIButton *cityLookMoreButton;
@property (weak, nonatomic) IBOutlet UIView *latestDiscountView;
@property (weak, nonatomic) IBOutlet UIButton *latestDiscountMoreButton;


@property (weak, nonatomic) IBOutlet UIButton *choicenieseTipsMoreButton;
@end
