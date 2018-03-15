//
//  GuideModel.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/3.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TravelModel.h"

@interface GuideModel : TravelModel
@property (nonatomic,copy) NSString *guide_id;
@property (nonatomic,copy) NSString *guide_cnname;
@property (nonatomic,copy) NSString *guide_enname;
@property (nonatomic,copy) NSString *guide_pinyin;
@property (nonatomic,copy) NSString *category_id;
@property (nonatomic,copy) NSString *category_title;
@property (nonatomic,copy) NSString *country_id;
@property (nonatomic,copy) NSString *country_name_cn;
@property (nonatomic,copy) NSString *country_name_en;
@property (nonatomic,copy) NSString *country_name_py;
@property (nonatomic,copy) NSString *cover;
@property (nonatomic,copy) NSNumber *download;
@property (nonatomic,copy) NSString *size;
@property (nonatomic,copy) NSString *update_time;
@property (nonatomic,copy) NSString *cover_updatetime;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *file;
@property (nonatomic,copy) NSString *update_log;
@property (nonatomic,retain) NSArray *city;
@end
