//
//  FeatureNotesCell.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/3.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureNotesModel.h"

@interface FeatureNotesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *notesImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

- (void)showDataWithModel:(FeatureNotesModel *)model;
@end
