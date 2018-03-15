//
//  SegModel.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/3.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TravelModel.h"

@interface SegModel : TravelModel
@property (nonatomic,copy) NSString *typeId;//手动赋值
@property (nonatomic,copy) NSString *catename;

//出发地
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *city_des;

//旅行时间
@property (nonatomic,copy) NSString *times;
@property (nonatomic,copy) NSString *timeDescription;


//目的地
@property (nonatomic,copy) NSNumber *continent_id;
@property (nonatomic,copy) NSString *continent_name;
@property (nonatomic,strong) NSArray *country;

@property (nonatomic,copy) NSString *country_id;
@property (nonatomic,copy) NSString *country_name;
@end
