//
//  FeatureHeaderView.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeatureHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *wiseButton;
@property (weak, nonatomic) IBOutlet UIButton *discountButton;
@property (weak, nonatomic) IBOutlet UIButton *journeyButton;

@end
