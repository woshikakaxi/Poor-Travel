//
//  QYDiscountViewController.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "ParentViewController.h"

@interface QYDiscountViewController : ParentViewController
@property (nonatomic,copy) NSString *type;

@property (nonatomic,copy) NSString *product_type;//机票。。。。
@property (nonatomic,copy) NSString *continent_id;//洲
@property (nonatomic,copy) NSString *country_id;//国家
@property (nonatomic,copy) NSString *departure;//出发地
@property (nonatomic,copy) NSString *times;//时间
@end
