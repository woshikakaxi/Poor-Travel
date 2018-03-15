//
//  BBSModel.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TravelModel.h"

@interface BBSModel : TravelModel
/*
 ——>data
 
 NSNumber    id          bbsId
 NSString    name
 NSArray     group
 
 —————>group
 NSNumber    id      groupSubId
 NSString    name
 NSString    total_threads
 NSString    photo
 NSArray     types
 
 
 ——————————>types
 NSNumber    id      typesId;
 NSString    name
 
 */
@property (nonatomic,copy) NSNumber *bbsId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSArray *group;

@property (nonatomic,copy) NSNumber *groupSubId;
@property (nonatomic,copy) NSString *total_threads;
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,strong) NSArray *types;


@property (nonatomic,copy) NSNumber *typesId;
@end
