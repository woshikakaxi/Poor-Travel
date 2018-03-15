//
//  CityDetailViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "CityDetailViewController.h"
#import "DestionDetailModel.h"
#import "FeatureNotesCell.h"
#import "TripsDetailViewController.h"
#import "CityHeaderView.h"

@interface CityDetailViewController () <UIScrollViewDelegate> {
    CityHeaderView * _headerView;
    NSDictionary * _headerDict;
}

@end

@implementation CityDetailViewController

- (void)createSearchBar {

}

- (void)createHeaderView {
    _headerDict = [[NSMutableDictionary alloc] init];
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"CityHeaderView" owner:self options:nil]lastObject];
    _headerView.frame = CGRectMake(0, 0, ScreenSize.width, 476);
    
    _tableView.tableHeaderView = _headerView;
}

- (void)fillHeaderView {
    NSArray * photoArr = _headerDict[@"photos"];
    _headerView.scrollView.contentSize = CGSizeMake(ScreenSize.width * photoArr.count, _headerView.scrollView.frame.size.height);
    _headerView.scrollView.delegate = self;
    _headerView.pageControl.numberOfPages = photoArr.count;
    _headerView.pageControl.currentPage = 0;
    for (int i = 0; i < photoArr.count; i++) {
        UIImageView * slideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenSize.width * i, 0, ScreenSize.width, _headerView.scrollView.frame.size.height)];
        [slideImageView sd_setImageWithURL:[NSURL URLWithString:photoArr[i]] placeholderImage:[UIImage imageNamed:@"default_plan_back"]];
        [_headerView.scrollView addSubview:slideImageView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _headerView.scrollView) {
        NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
        _headerView.pageControl.currentPage = page;
    }
}

- (void)addTaskWithUrl:(NSString *)url finished:(SEL)selector {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setObject:url forKey:url];
    [_manager GET:url parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
              [self performSelectorInBackground:selector withObject:responseObject];
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
              NSLog(@"%@ : %@",[self class],error);
          }];
}

- (void)downLoadFinished:(id)responseObject {
    NSDictionary * countryDict = responseObject[@"data"];
    //NSLog(@"%@",responseObject);
    _headerDict = countryDict;
    NSArray * tripArr = countryDict[@"new_trip"];
    for (NSDictionary * dict in tripArr) {
        DestionDetailModel * desModel = [[DestionDetailModel alloc] init];
        [desModel setValuesForKeysWithDictionary:dict];
        [_dataArr addObject:desModel];
    }
    [self fillHeaderView];
    [_tableView reloadData];
}

- (void)setNavigation {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.frame = CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - 64 - 49);
    [self createHeaderView];
    [self addTaskWithUrl:[NSString stringWithFormat:City_Detail_URL,_cityId] finished:@selector(downLoadFinished:)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"FeatureNotesCell";
    FeatureNotesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FeatureNotesCell" owner:self options:nil] lastObject];
    }
    DestionDetailModel *model = _dataArr[indexPath.row];
    [cell.notesImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"communityDefault"]];
    cell.titleLabel.text = model.title;
    cell.userNameLabel.text = model.username;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TripsDetailViewController * vc = [[TripsDetailViewController alloc] init];
    DestionDetailModel * model = _dataArr[indexPath.row];
    vc.viewUrl = model.view_url;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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
