//
//  RecommendViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "RecommendViewController.h"
#import "FeatureHeaderView.h"
#import "FeatureModel.h"
#import "MyImageView.h"
#import "SlideViewController.h"
#import "GuideViewController.h"
#import "QYDiscountViewController.h"
#import "UserDetailViewController.h"
#import "MguideDetailViewController.h"
#import "DiscountDetailViewController.h"
#import "FeatureNotesModel.h"
#import "Define.h"
#import "TripsDetailViewController.h"
#import "FeatureNotesCell.h"
#import <UIKit/UIKit.h>

@interface RecommendViewController () <UIScrollViewDelegate> {
    FeatureHeaderView * _headerView;
    NSMutableArray * _headerArr;
    NSTimer * _timer;
    NSInteger _index;
    NSInteger _slideNum;
}

@end

@implementation RecommendViewController

- (void)dealloc {
    
    if ([_timer isValid]) {
        [_timer invalidate];
    }
}

- (void)createFeatureHeaderView {
    FeatureModel * model = _headerArr[0];
    _searchBar.placeholder = model.search;
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"FeatureHeaderView" owner:self options:nil]lastObject];
    
    UIView * view = _tableView.tableHeaderView;
    view.frame = CGRectMake(0, 0, ScreenSize.width, 1221);
    _tableView.tableHeaderView = view;
    
    [self contentScrollViewSlide:model];
    [self fillHeadTipsViewWithModel:model];
    [self fillHeadDisCountViewWithModel:model];
    _tableView.tableHeaderView = _headerView;
}

- (void)contentScrollViewSlide:(FeatureModel *)model {
    NSArray * slide = model.slide;
    _slideNum = slide.count;
    _headerView.pageControl.numberOfPages = slide.count;
    _headerView.pageControl.currentPage = 0;
    for (int i = 0; i < slide.count; i++) {
        NSDictionary * dict = slide[i];
        MyImageView * imageView = [[MyImageView alloc] initWithFrame:CGRectMake(ScreenSize.width * i, 0, ScreenSize.width, _headerView.scrollView.frame.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"photo"]] placeholderImage:[UIImage imageNamed:@"default_plan_back"]];
        imageView.url = dict[@"url"];
        [imageView addTarget:self action:@selector(imageViewClick:)];
        [_headerView.scrollView addSubview:imageView];
    }
    _headerView.scrollView.delegate = self;
    _headerView.scrollView.contentSize = CGSizeMake(ScreenSize.width * slide.count, _headerView.scrollView.frame.size.height);
    
    _headerView.wiseButton.tag = 2001;
    [_headerView.wiseButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _headerView.discountButton.tag = 2002;
    [_headerView.discountButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)imageViewClick:(MyImageView *)imageView {
    SlideViewController * vc = [[SlideViewController alloc] init];
    vc.url = imageView.url;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnClick:(UIButton *)btn {
    switch (btn.tag) {
        case 2001:
        {
            GuideViewController * guide = [[GuideViewController alloc] init];
            [self.navigationController pushViewController:guide animated:YES];
        }
            break;
            
        case 2002:
        {
            QYDiscountViewController * vc = [[QYDiscountViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 2003:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _headerView.scrollView) {
        NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
        _headerView.pageControl.currentPage = page;
    }
}

- (void)fillHeadTipsViewWithModel:(FeatureModel *)model {
    NSArray * mguideArr = model.mguide;
    
    for (int i = 0; i < mguideArr.count; i++) {
        NSDictionary * dict = mguideArr[i];
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(10 + (9 + 173) * ( i % 2 ), 367 + (177 + 13) * (i/2), 173, 177)];
        MyImageView * tipImageView = [[MyImageView alloc] initWithFrame:CGRectMake(0, 0, 173, 133)];
        [tipImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"photo"]] placeholderImage:[UIImage imageNamed:@"default_plan_back"]];
        tipImageView.mguID = dict[@"id"];
        [tipImageView addTarget:self action:@selector(tipImageViewClick:)];
        [view addSubview:tipImageView];
        
        MyImageView * userHeadImageView = [[MyImageView alloc] initWithFrame:CGRectMake(0, 109, 40, 40)];
        userHeadImageView.layer.masksToBounds = YES;
        userHeadImageView.layer.cornerRadius = 20;
        [userHeadImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"avatar"]] placeholderImage:[UIImage imageNamed:@"communityDefault"]];
        userHeadImageView.userID = dict[@"user_id"];
        [userHeadImageView addTarget:self action:@selector(tipHeadImageViewClick:)];
        [view addSubview:userHeadImageView];
        
        UILabel * userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(48, 133, 125, 11)];
        userNameLabel.font = [UIFont systemFontOfSize:11];
        userNameLabel.text = dict[@"username"];
        [view addSubview:userNameLabel];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 149, 173, 36)];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.numberOfLines = 0;
        titleLabel.text = dict[@"title"];
        [view addSubview:titleLabel];
        [_headerView addSubview:view];
    }
}

- (void)tipImageViewClick:(MyImageView *)imageView {
    MguideDetailViewController * vc = [[MguideDetailViewController alloc] init];
    vc.mguideID = imageView.mguID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tipHeadImageViewClick:(MyImageView *)imageView {
    UserDetailViewController * vc = [[UserDetailViewController alloc] init];
    vc.userID = imageView.userID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)fillHeadDisCountViewWithModel:(FeatureModel *)model {
    NSArray * arr = model.discount;
    for (int i = 0; i < arr.count; i++) {
        NSDictionary * dict = arr[i];
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(10 + (173+10) * (i%2), 795 + (185+9) * (i/2), 173, 185)];
        MyImageView * discountImageView = [[MyImageView alloc] initWithFrame:CGRectMake(0, 0, 173, 132)];
        [discountImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"photo"]] placeholderImage:[UIImage imageNamed:@"default_plan_back"]];
        
        discountImageView.discountID = dict[@"id"];
        [discountImageView addTarget:self action:@selector(discountImageClick:)];
        [view addSubview:discountImageView];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 131, 173, 35)];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.numberOfLines = 0;
        titleLabel.text = dict[@"title"];
        [view addSubview:titleLabel];
        
        UIImageView * timeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 162, 15, 15)];
        timeView.image = [UIImage imageNamed:@"lastMinute_time"];
        [view addSubview:timeView];
        
        UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 165, 98, 12)];
        timeLabel.font = [UIFont systemFontOfSize:10];
        timeLabel.text = dict[@"end_date"];
        timeLabel.textColor = [UIColor grayColor];
        [view addSubview:timeLabel];
        
        UIImageView * priceOffImageView = [[UIImageView alloc] initWithFrame:CGRectMake(67, 92, 104, 31)];
        priceOffImageView.image = [UIImage imageNamed:@"redCard"];
        [view addSubview:priceOffImageView];
        
        UILabel * priceOffLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 92, 96, 31)];
        
        //<em>8000</em>元起
        NSString * priceText = dict[@"price"];
        NSArray * arr = [priceText componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
        NSString * resultStr = [NSString stringWithFormat:@"%@%@",arr[2],arr[4]];
        //NSLog(@"%@",arr);
        priceOffLabel.text = resultStr;
        priceOffLabel.font = [UIFont systemFontOfSize:15];
        priceOffLabel.textColor = [UIColor whiteColor];
        [view addSubview:priceOffLabel];
        
        UILabel * discountOffLabel = [[UILabel alloc] initWithFrame:CGRectMake(129, 164, 42, 11)];
        discountOffLabel.font = [UIFont systemFontOfSize:10];
        discountOffLabel.textColor = [UIColor redColor];
        discountOffLabel.text = dict[@"priceoff"];
        [view addSubview:discountOffLabel];
        
        [_headerView addSubview:view];
    }
}

- (void)discountImageClick:(MyImageView *)imageView {
    DiscountDetailViewController * vc = [[DiscountDetailViewController alloc] init];
    vc.discountID = imageView.discountID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addTaskWithUrl:(NSString *)url finish:(SEL)selector {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    if (_isPullRefreshing) {
        [_headerArr removeAllObjects];
        [_dataArr removeAllObjects];
    }
    [_currentTask setObject:url forKey:url];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_currentTask removeObjectForKey:url];
        [self performSelectorInBackground:selector withObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_currentTask removeObjectForKey:url];
        NSLog(@"%@ : %@",[self class],error);
    }];
    [self endRefreshing];
}

- (void)downloadHeaderFinished:(id)responseObject {
    NSDictionary * dict = responseObject[@"data"];
    FeatureModel * model = [[FeatureModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    [_headerArr addObject:model];
    
    [self createFeatureHeaderView];
}

- (void)downloadNotesFinished:(id)responseObject {
    for (NSDictionary * dict in responseObject[@"data"]) {
        FeatureNotesModel * model = [[FeatureNotesModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [_dataArr addObject:model];
    }
    [_tableView reloadData];
}

- (void)creatRefreshing {
    __block UITableView * tableView = _tableView;
    [tableView addHeaderWithCallback:^{
        if (_isPullRefreshing) {
            return;
        }
        _isPullRefreshing = YES;
        _currentPage = 1;
        [self addTaskWithUrl:Feature_Header_URL finish:@selector(downloadHeaderFinished:)];
        NSString * url = [NSString stringWithFormat:Feature_Notes_URL,_currentPage];
        [self addTaskWithUrl:url finish:@selector(downloadNotesFinished:)];
    }];
    [tableView addFooterWithCallback:^{
        if (_isLoadMore) {
            return ;
        }
        _isLoadMore = YES;
        _currentPage ++;
        NSString *url = [NSString stringWithFormat:Feature_Notes_URL,_currentPage];
        
        [self addTaskWithUrl:url finish:@selector(downloadNotesFinished:)];
    }];
}

- (void)endRefreshing {
    _isLoadMore = NO;
    _isPullRefreshing = NO;
    [_tableView headerEndRefreshing];
    [_tableView footerEndRefreshing];
}

- (void)createTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(pageUp) userInfo:nil repeats:YES];
}

- (void)pageUp {
    if (_headerView.scrollView.contentOffset.x >= (_slideNum - 1) * ScreenSize.width) {
        _headerView.scrollView.contentOffset = CGPointMake(0, 0);
        _index = 0;
        _headerView.pageControl.currentPage = _index;
    } else {
        _index++;
        [_headerView.scrollView setContentOffset:CGPointMake(_headerView.scrollView.frame.size.width * _index, 0) animated:YES];
        _headerView.pageControl.currentPage = _index;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithTitle:@"推荐"];
    _headerArr = [[NSMutableArray alloc] init];
    [self addTaskWithUrl:Feature_Header_URL finish:@selector(downloadHeaderFinished:)];
    _currentPage = 1;
    [self addTaskWithUrl:[NSString stringWithFormat:Feature_Notes_URL,_currentPage] finish:@selector(downloadNotesFinished:)];
    [self creatRefreshing];
    [self createTimer];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FeatureNotesModel * model = _dataArr[indexPath.row];
    TripsDetailViewController * vc = [[TripsDetailViewController alloc] init];
    vc.viewUrl = model.view_url;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"FeatureNotesCell";
    FeatureNotesCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FeatureNotesCell" owner:self options:nil] lastObject];
    }
    FeatureNotesModel * model = _dataArr[indexPath.row];
    [cell showDataWithModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
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
