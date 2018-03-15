//
//  MguideDetailCell.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/3.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarLevelView.h"

@interface MguideDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mguideImageView;
@property (weak, nonatomic) IBOutlet UILabel *englishNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chineseNameLabel;
@property (weak, nonatomic) IBOutlet StarLevelView *starLevelView;
@property (weak, nonatomic) IBOutlet UILabel *mguideContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *mguideCollectionButton;
@end
