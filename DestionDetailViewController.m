//
//  DestionDetailViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "DestionDetailViewController.h"
#import "MyImageView.h"
#import "DestionDetailModel.h"
#import "DestionDetailHeaderModel.h"
#import "DestionDetailHeaderView.h"

//cell使用之前的
#import "FeatureNotesCell.h"

#import "DiscountDetailViewController.h"
#import "TripsDetailViewController.h"
#import "CityListViewController.h"
#import "DiscountListViewController.h"
#import "CityDetailViewController.h"

#import "MapViewController.h"

@interface DestionDetailViewController () <UIScrollViewDelegate> {
    DestionDetailHeaderView * _headerView;
    DestionDetailHeaderModel * _headerModel;
}

@end

@implementation DestionDetailViewController

- (void)createSearchBar {
    
}

- (void)createHeaderView {
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"DestionDetailHeaderView" owner:self options:nil]lastObject];
    _headerView.frame = CGRectMake(0, 0, ScreenSize.width, 1109);
    
    [_headerView.cityLookMoreButton addTarget:self action:@selector(cityLookMoreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.latestDiscountMoreButton addTarget:self action:@selector(latestDiscountMoreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableHeaderView = _headerView;
}

- (void)cityLookMoreButtonClick:(UIButton *)button {
    CityListViewController * vc = [[CityListViewController alloc] init];
    vc.countryId = self.pid;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)latestDiscountMoreButtonClick:(UIButton *)button {
    DiscountListViewController * vc = [[DiscountListViewController alloc] init];
    vc.countryId = self.pid;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)fillHeaderView {
    NSArray * photoArr = _headerModel.photos;
    _headerView.pageControl.numberOfPages = photoArr.count;
    _headerView.pageControl.currentPage = 0;
    _headerView.topScrollView.contentSize = CGSizeMake(ScreenSize.width * photoArr.count, _headerView.topScrollView.frame.size.height);
    
    for (int i = 0; i < photoArr.count; i++) {
        UIImageView * slideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenSize.width * i, 0, ScreenSize.width, _headerView.topScrollView.frame.size.height)];
        [slideImageView sd_setImageWithURL:[NSURL URLWithString:photoArr[i]] placeholderImage:[UIImage imageNamed:@"default_plan_back"]];
        [_headerView.topScrollView addSubview:slideImageView];
    }
    _headerView.topScrollView.delegate = self;
    
    NSArray * hotCityArr = _headerModel.hot_city;
    for (int i = 0; i < hotCityArr.count; i++) {
        NSDictionary * cityDict = hotCityArr[i];
        UIView * cityBackView = [[UIView alloc] initWithFrame:CGRectMake(10 + (112 + 10) * (i % 3), 40 + (112 + 10) * (i / 3), 112, 112)];
        MyImageView * cityImageView = [[MyImageView alloc] initWithFrame:CGRectMake(0, 0, 112, 112)];
        [cityImageView sd_setImageWithURL:[NSURL URLWithString:cityDict[@"photo"]] placeholderImage:[UIImage imageNamed:@"communityDefault"]];
        
        cityImageView.pid = cityDict[@"id"];
        [cityImageView addTarget:self action:@selector(hotCityImageViewClick:)];
        [cityBackView addSubview:cityImageView];
        
        UILabel * backLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 91, 112, 21)];
        backLabel.backgroundColor = [UIColor darkGrayColor];
        backLabel.alpha = 0.5;
        [cityBackView addSubview:backLabel];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 91, 112, 21)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = cityDict[@"name"];
        [cityBackView addSubview:label];
        
        [_headerView.cityView addSubview:cityBackView];
    }
    
    NSArray * discountArr = _headerModel.latest_discount;
    for (int i = 0; i < discountArr.count; i++) {
        NSDictionary * discountDict = discountArr[i];
        
        UIView * disView = [[UIView alloc] initWithFrame:CGRectMake(10 + (173 + 9) * (i % 2), 40 + (201 + 10) * (i / 2), 173, 201)];
        MyImageView * disImageView = [[MyImageView alloc] initWithFrame:CGRectMake(0, 0, 173, 130)];
        [disImageView sd_setImageWithURL:[NSURL URLWithString:discountDict[@"photo"]] placeholderImage:[UIImage imageNamed:@"communityDefault"]];
        disImageView.pid = discountDict[@"id"];
        [disImageView addTarget:self action:@selector(disImageViewClick:)];
        [disView addSubview:disImageView];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 138, 153, 30)];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.numberOfLines = 0;
        titleLabel.text = discountDict[@"title"];
        [disView addSubview:titleLabel];
        
        UILabel * expireLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 176, 109, 12)];
        expireLabel.text = discountDict[@"expire_date"];
        expireLabel.textColor = [UIColor darkGrayColor];
        expireLabel.font = [UIFont systemFontOfSize:11];
        [disView addSubview:expireLabel];
        
        UIImageView * dismarkView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 98, 85, 25)];
        dismarkView.image = [UIImage imageNamed:@"discount_price_back"];
        [disView addSubview:dismarkView];
        
        UILabel * dismarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 98, 85, 25)];
        dismarkLabel.textColor = [UIColor whiteColor];
        dismarkLabel.font = [UIFont systemFontOfSize:16];
        
        NSString * dismarkStr = discountDict[@"price"];
        NSArray * arr = [dismarkStr componentsSeparatedByString:@"</"];
        NSString * str = arr[0];
        NSString * priceStr = [str substringFromIndex:4];
        dismarkLabel.text = [NSString stringWithFormat:@"%@元起",priceStr];
        
        UIImageView * timeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(8, 169, 24, 24)];
        timeIcon.image = [UIImage imageNamed:@"时间icon"];
        [disView addSubview:timeIcon];
        
        [disView addSubview:dismarkLabel];
        
        [_headerView.latestDiscountView addSubview:disView];
    }
}

- (void)disImageViewClick:(MyImageView *)discountImageView {
    DiscountDetailViewController * vc = [[DiscountDetailViewController alloc] init];
    vc.discountID = discountImageView.pid;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)hotCityImageViewClick:(MyImageView *)hotCityImageView {
    CityDetailViewController * vc = [[CityDetailViewController alloc] init];
    vc.cityId = hotCityImageView.pid;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _headerView.topScrollView) {
        NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
        _headerView.pageControl.currentPage = page;
    }
}

- (void)addTaskWithUrl:(NSString *)url finished:(SEL)selector {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setObject:url forKey:url];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
        [self performSelector:selector withObject:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
        NSLog(@"%@:%@",[self class],error);
    }];
}

- (void)downLoadFinished:(id)responseObject {
    NSDictionary * countryDict = responseObject[@"data"];
    
    _headerModel = [[DestionDetailHeaderModel alloc] init];
    [_headerModel setValuesForKeysWithDictionary:countryDict];
    _headerModel.countryId = countryDict[@"id"];
    _headerModel.latest_discount = countryDict[@"new_discount"];
    
    NSArray * tripArr = countryDict[@"new_trip"];
    for (NSDictionary * dict in tripArr) {
        DestionDetailModel * desModel = [[DestionDetailModel alloc] init];
        [desModel setValuesForKeysWithDictionary:dict];
        [_dataArr addObject:desModel];
    }
    [self fillHeaderView];
    [self setNavigation:countryDict];
    [_tableView reloadData];
}

- (void)setNavigation:(NSDictionary *)dict {
    [self addTitleViewWithTitle:[NSString stringWithFormat:@"%@\n %@",dict[@"chinesename"],dict[@"englishname"]]];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setBackgroundImage:[[UIImage imageNamed:@"poi_微锦囊"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    button.tag = [_headerModel.countryId intValue];
    [button addTarget:self action:@selector(mapButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)mapButtonClick:(UIButton *)button {
    MapViewController * vc = [[MapViewController alloc] init];
    vc.countryId = [NSString stringWithFormat:@"%ld",button.tag];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.frame = CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - 64 - 49);
    [self createHeaderView];
    [self addTaskWithUrl:[NSString stringWithFormat:Destion_Detail_URL,self.pid] finished:@selector(downLoadFinished:)];
}

#pragma mark - UITableViewDataSource
/*
 @property (weak, nonatomic) IBOutlet UIImageView *notesImageView;
 @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
 @property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeatureNotesCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FeatureNotesCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FeatureNotesCell" owner:self options:nil]lastObject];
    }
    DestionDetailModel * model = _dataArr[indexPath.row];
    [cell.notesImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"communityDefault"]];
    cell.titleLabel.text = model.title;
    cell.userNameLabel.text = model.username;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DestionDetailModel * model = _dataArr[indexPath.row];
    TripsDetailViewController * vc = [[TripsDetailViewController alloc] init];
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
