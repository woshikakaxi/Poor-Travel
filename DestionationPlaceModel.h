//
//  DestionationPlaceModel.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TravelModel.h"

@interface DestionationPlaceModel : TravelModel
@property (nonatomic,copy) NSString *catename;
@property (nonatomic,copy) NSString *catename_en;
@property (nonatomic,strong) NSArray *countrylist;
@property (nonatomic,strong) NSArray *hotcountrylist;
@end
