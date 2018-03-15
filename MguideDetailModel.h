//
//  MguideDetailModel.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/3.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TravelModel.h"

@interface MguideDetailModel : TravelModel
@property (nonatomic,copy) NSString *mguid;
@property (nonatomic,copy) NSString *firstname;
@property (nonatomic,copy) NSString *secondname;
@property (nonatomic,copy) NSString *localname;
@property (nonatomic,copy) NSString *chinesename;
@property (nonatomic,copy) NSString *englishname;
@property (nonatomic,copy) NSString *countryname;
@property (nonatomic,copy) NSString *cityname;
@property (nonatomic,copy) NSString *lat;
@property (nonatomic,copy) NSString *lng;
@property (nonatomic,copy) NSNumber *mapstatus;
@property (nonatomic,copy) NSNumber *recommandstar;
@property (nonatomic,copy) NSNumber *planto;
@property (nonatomic,copy) NSNumber *beento;
@property (nonatomic,copy) NSNumber *beennumber;
@property (nonatomic,copy) NSString *beenstr;
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,copy) NSString *descriptionContent;
@end
