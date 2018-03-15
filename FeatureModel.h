//
//  FeatureModel.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TravelModel.h"

@interface FeatureModel : TravelModel
/*
 place:
 url
 photo
 title
 label
 */
@property (nonatomic,retain) NSArray *place;
/*
 slide
 url
 photo
 */
@property (nonatomic,retain) NSArray *slide;
/*
 mguide
 id
 photo
 title
 user_id
 username
 avatar
 description
 count
 */
@property (nonatomic,retain) NSArray *mguide;
/*
 discount
 open_type
 title
 content
 ids
 price
 url
 photo
 big_pic
 */
//////////////////////////
/*
 id
 title
 price
 priceoff
 end_date
 photo
 */
@property (nonatomic,retain) NSArray *discount;
/*
 trip
 photo
 title
 lastpost
 user_id
 username
 avatar
 replys
 likes
 view_url
 view_author_url
 views
 digest_level
 */
@property (nonatomic,retain) NSArray *trip;
@property (nonatomic,copy) NSString *search;
@end
