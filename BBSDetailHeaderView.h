//
//  BBSDetailHeaderView.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *bbsImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *inviationCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton *digestButton;
@property (weak, nonatomic) IBOutlet UIButton *latestButton;
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;
@end
