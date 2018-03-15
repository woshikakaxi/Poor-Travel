//
//  TravellingViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/5.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TravellingViewController.h"
#import "TravelingCityViewController.h"

@interface TravellingViewController ()

@end

@implementation TravellingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithTitle:@"旅途中"];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)locationButtonClick:(id)sender {

}

- (IBAction)cityButtonClick:(id)sender {
    TravelingCityViewController * vc = [[TravelingCityViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
