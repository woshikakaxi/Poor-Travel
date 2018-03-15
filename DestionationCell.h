//
//  DestionationCell.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestionationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *placeImageView1;

@property (weak, nonatomic) IBOutlet UILabel *placeCount1;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel1;
@property (weak, nonatomic) IBOutlet UILabel *englishNameLabel1;
@property (weak, nonatomic) IBOutlet UIButton *placeImageButton1;


@property (weak, nonatomic) IBOutlet UIImageView *placeImageView2;

@property (weak, nonatomic) IBOutlet UILabel *placeCount2;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel2;
@property (weak, nonatomic) IBOutlet UILabel *englishNameLabel2;
@property (weak, nonatomic) IBOutlet UIButton *placeImageButton2;
@end
