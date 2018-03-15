//
//  TravelViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TravelViewController.h"

@interface TravelViewController ()

@end

@implementation TravelViewController

- (void)createSearchBar {
    UIImageView * backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 30)];
    backImageView.image = [UIImage imageNamed:@"home_head"];
    [self.view addSubview:backImageView];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 0, ScreenSize.width - 40, 30)];
    _searchBar.barStyle = UISearchBarStyleDefault;
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.delegate = self;
    _searchBar.translucent = NO;
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [_searchBar setTranslucent:YES];
    [self.view addSubview:_searchBar];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_searchBar resignFirstResponder];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - 49 - 30) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)creatRefreshing {

}

- (void)endRefreshing {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self createSearchBar];
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
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
