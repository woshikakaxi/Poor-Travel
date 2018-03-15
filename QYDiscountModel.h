//
//  QYDiscountModel.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/3.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TravelModel.h"

@interface QYDiscountModel : TravelModel
@property (nonatomic,copy) NSString *discountId;
@property (nonatomic,copy) NSString *pic;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *booktype;
@property (nonatomic,copy) NSString *firstpay_end_time;
@property (nonatomic,copy) NSString *end_date;
@property (nonatomic,copy) NSString *list_price;
@property (nonatomic,copy) NSString *buy_price;
@property (nonatomic,copy) NSString *lastminute_des;
@property (nonatomic,copy) NSString *url;
@end
