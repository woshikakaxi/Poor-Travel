//
//  MapViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "AFNetworking.h"

@interface MapViewController () <CLLocationManagerDelegate,MKMapViewDelegate> {
    MKMapView * _mapView;
    CLLocationManager * _manager;
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTask:[NSString stringWithFormat:Country_Lat_URl,_countryId]];
    [self createMapView];
    // Do any additional setup after loading the view.
}

- (void)createMapView {
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(_lat, _lng);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [_mapView setRegion:region animated:YES];
}

- (void)addTask:(NSString *)url {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = responseObject[@"data"][0];
        self.lat = [dict[@"lat"] floatValue];
        self.lng = [dict[@"lng"] floatValue];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"地图数据请求失败");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
