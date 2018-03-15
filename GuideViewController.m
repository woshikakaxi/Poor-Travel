//
//  GuideViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "GuideViewController.h"
#import "GuideModel.h"
#import "GuideViewCell.h"

@interface GuideViewController () <UITableViewDataSource,UITableViewDelegate> {
    UITableView * _tableView;
    NSMutableArray * _currentDataArr;
    NSString * _selectString;
    NSMutableArray * _countryNameArr;
    NSMutableArray * _cellDataArr;
    UIView * _drawerView;
}

@end

@implementation GuideViewController

- (void)createSwipeGesture {
    UISwipeGestureRecognizer * swipeLeft = [[UISwipeGestureRecognizer alloc] init];
    [swipeLeft addTarget:self action:@selector(gestureRecognizerLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
}

- (void)gestureRecognizerLeft:(UISwipeGestureRecognizer *)left {
    CGRect tableViewFrame = _tableView.frame;
    tableViewFrame.origin.x = 0;
    CGRect frame = _drawerView.frame;
    frame.origin.x = -100;
    [UIView animateWithDuration:0.5 animations:^{
        _tableView.frame = tableViewFrame;
        _drawerView.frame = frame;
    } completion:nil];
}

- (void)gestureRecognizerRight:(UISwipeGestureRecognizer *)right {
    CGRect tableViewFrame = _tableView.frame;
    tableViewFrame.origin.x = 100;
    CGRect frame = _drawerView.frame;
    frame.origin.x = 0;
    [UIView animateWithDuration:0.5 animations:^{
        _tableView.frame = tableViewFrame;
        _drawerView.frame = frame;
    }];
}

- (void)creatDrawerView {
    _selectString = @"亚洲";
    _drawerView = [[UIView alloc] initWithFrame:CGRectMake(-100, 0, 100, ScreenSize.height - 64)];
    
    UILabel * backLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, ScreenSize.height - 64)];
    backLabel.backgroundColor = [UIColor lightGrayColor];
    backLabel.alpha = 0.5;
    [_drawerView addSubview:backLabel];
    
     NSArray *countryNames = @[@"亚洲",@"欧洲",@"北美洲",@"南美洲",@"大洋洲",@"非洲",@"专题"];
    for (int i = 0; i < countryNames.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(0, 61 * i, 100, 60);
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:countryNames[i] forState:UIControlStateNormal];
        
        UIImageView * lineView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 61 * i, 90, 1)];
        lineView.image = [UIImage imageNamed:@"cut_off_rule"];
        [_drawerView addSubview:lineView];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        btn.tag = 101 + i;
        [btn addTarget:self action:@selector(drawerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_drawerView addSubview:btn];
    }
    [self.view addSubview:_drawerView];
}

- (void)drawerButtonClick:(UIButton *)btn {
    [_currentDataArr removeAllObjects];
    [_cellDataArr removeAllObjects];
    [_countryNameArr removeAllObjects];
    _selectString = btn.currentTitle;
    
    for (GuideModel * model in _dataArr) {
        if ([model.category_title isEqualToString:_selectString]) {
            [_currentDataArr addObject:model];
        }
    }
    for (int i = 0; i < _currentDataArr.count; i++) {
        GuideModel * model = _currentDataArr[i];
        if (![_countryNameArr containsObject:model.country_name_cn]) {
            [_countryNameArr addObject:model.country_name_cn];
        }
    }
    for (int i = 0; i < _countryNameArr.count; i++) {
        NSMutableArray * tempArr = [[NSMutableArray alloc] init];
        for (GuideModel * model in _currentDataArr) {
            if ([model.country_name_cn isEqualToString:_countryNameArr[i]]) {
                [tempArr addObject:model];
            }
        }
        [_cellDataArr addObject:tempArr];
    }
    [_tableView reloadData];
}

- (void)createTableView {
    _currentDataArr = [[NSMutableArray alloc] init];
    _countryNameArr = [[NSMutableArray alloc] init];
    _cellDataArr = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)addTaskWithUrl:(NSString *)url finish:(SEL)selector {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setObject:url forKey:url];
    NSDictionary * parameters = @{@"client_id":@"qyer_android",@"client_secret":@"9fcaae8aefc4f9ac4915",@"v":@"1",@"track_deviceid":@"357474045959836",@"track_app_version":@"6.0",@"track_app_channel":@"360m"};
    [_manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_currentTask setObject:url forKey:url];
        [self performSelector:selector withObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_currentTask setObject:url forKey:url];
        NSLog(@"%@ : %@",[self class],error);
    }];
}

- (void)receivePostResponse:(id)responseObject {
    NSArray * arr = responseObject[@"data"];
    for (NSDictionary * dict in arr) {
        GuideModel * model = [[GuideModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        if ([model.category_title isEqualToString:@"亚洲"]) {
            [_currentDataArr addObject:model];
        }
        [_dataArr addObject:model];
    }
    
    
    for (int i = 0; i < _currentDataArr.count; i++) {
        GuideModel * model = _currentDataArr[i];
        if (![_countryNameArr containsObject:model.country_name_cn]) {
            [_countryNameArr addObject:model.country_name_cn];
        }
    }
    for (int i = 0; i < _countryNameArr.count; i++) {
        NSMutableArray * tempArr = [[NSMutableArray alloc] init];
        for (GuideModel * model  in _currentDataArr) {
            if ([model.country_name_cn isEqualToString:_countryNameArr[i]]) {
                [tempArr addObject:model];
            }
        }
        [_cellDataArr addObject:tempArr];
    }
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createTableView];
    [self creatDrawerView];
    [self createSwipeGesture];
    self.title = @"穷游锦囊";
    [self addTaskWithUrl:Guide_URL finish:@selector(receivePostResponse:)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GuideViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GuideViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GuideViewCell" owner:self options:nil]lastObject];
    }
    NSArray * arr = _cellDataArr[indexPath.section];
    
    GuideModel * model1 = arr[indexPath.row * 2];
    GuideModel * model2 = nil;
    if (indexPath.row * 2 + 1 < arr.count) {
        model2 = arr[indexPath.row * 2 + 1];
    }
    NSString* url1 = [model1.cover stringByAppendingFormat:@"/260_390.jpg?%@",model1.cover_updatetime];
    [cell.guideImageView1 sd_setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"Board_Normal"]];
    
    if (indexPath.row * 2 + 1 < arr.count) {
        NSString *url2 = [model2.cover stringByAppendingFormat:@"/260_390.jpg?%@",model2.cover_updatetime];
        [cell.guideImageView2 sd_setImageWithURL:[NSURL URLWithString:url2] placeholderImage:[UIImage imageNamed:@"Board_Normal"]];
    } else {
        cell.guideImageView2.image = nil;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _countryNameArr[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ([_cellDataArr[section] count] + 1) / 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _cellDataArr.count;
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
