//
//  CityListModel.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TravelModel.h"

@interface CityListModel : TravelModel
@property (nonatomic,copy) NSString *cityID;
@property (nonatomic,copy) NSString *catename;
@property (nonatomic,copy) NSString *catename_en;
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,copy) NSString *lat;
@property (nonatomic,copy) NSString *lng;
@property (nonatomic,copy) NSString *beennumber;
@property (nonatomic,copy) NSString *beenstr;
@property (nonatomic,copy) NSString *representative;
@end
