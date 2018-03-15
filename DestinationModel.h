//
//  DestinationModel.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TravelModel.h"

@interface DestinationModel : TravelModel
@property (nonatomic,copy) NSString *catename;
@property (nonatomic,copy) NSString *catename_en;
@property (nonatomic,copy) NSString *count;
@property (nonatomic,copy) NSNumber *flag;
@property (nonatomic,copy) NSString *label;
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,copy) NSString *pid;
@end
