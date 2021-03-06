//
//  FeatureNotesModel.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TravelModel.h"

@interface FeatureNotesModel : TravelModel
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *lastpost;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *replys;
@property (nonatomic,copy) NSString *likes;
@property (nonatomic,copy) NSString *view_url;
@property (nonatomic,copy) NSString *view_author_url;
@property (nonatomic,copy) NSNumber *views;
@property (nonatomic,copy) NSNumber *digest_level;
@end
