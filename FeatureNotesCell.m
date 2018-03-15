//
//  FeatureNotesCell.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/3.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "FeatureNotesCell.h"
#import "UIImageView+WebCache.h"

@implementation FeatureNotesCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//@property (weak, nonatomic) IBOutlet UIImageView *notesImageView;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

- (void)showDataWithModel:(FeatureNotesModel *)model {
    [self.notesImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"lastMinuteNormalPic"]];
    self.titleLabel.text = model.title;
    self.userNameLabel.text = model.username;
}

@end
