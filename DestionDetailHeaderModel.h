//
//  DestionDetailHeaderModel.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TravelModel.h"

@interface DestionDetailHeaderModel : TravelModel
@property (nonatomic,copy) NSString *countryId;//手动赋值  id
@property (nonatomic,copy) NSString *chinesename;
@property (nonatomic,copy) NSString *englishname;
@property (nonatomic,copy) NSString *planto;
@property (nonatomic,copy) NSString *beento;
@property (nonatomic,strong) NSArray *photos;
@property (nonatomic,copy) NSString *overview_url;

/*
 id  "63"
 name "东京"
 photo "photo"
 */
@property (nonatomic,strong) NSArray *hot_city;


/*
 id "20166"
 title "上海飞冲绳.."
 price "<em>1999</em>元起"
 expire_date "2015.06.15结束"
 photo
 big_pic
 */
@property (nonatomic,strong) NSArray *latest_discount; //手动赋值  new_discount

//@property (nonatomic,strong) NSArray *latest_trip //手动赋值  new_trip
@end
