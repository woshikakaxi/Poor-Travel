//
//  MapViewController.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController
@property (nonatomic, copy) NSString * countryId;

/*
 经度：普通话拼音：jīng dù ； 英文：longitude ； 英文读音：/'lɒŋɡɪtjuːd/；美 /'lɑːndʒətuːd/
 纬度：普通话拼音：wěi dù ； 英文：latitude ; 英文读音：/'lætɪtjuːd/；美 /'lætɪtuːd/
 */

@property (nonatomic, assign) float lat;//纬度
@property (nonatomic, assign) float lng;//经度
@end
