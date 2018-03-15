//
//  MyImageView.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyImageView : UIImageView
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *mguID;
@property (nonatomic,copy) NSString *userID;
@property (nonatomic,copy) NSString *discountID;

@property (nonatomic,copy) NSString *pid;

//记录图片的索引
@property (nonatomic)NSInteger index;
//增加点击事件
- (void)addTarget:(id)target action:(SEL)action;
@end
