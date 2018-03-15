//
//  DestinationViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "DestinationViewController.h"
#import "DestionationPlaceModel.h"
#import "DestinationModel.h"
#import "DestionationCell.h"
#import "DestionationOtherModel.h"

#import "DestionDetailViewController.h"

@interface DestinationViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView * _tabelView;
    UIView * _drawerView;
    NSString * _selectString;
    
    NSMutableArray * _hotCountryArr;
    NSMutableArray * _otherCountryArr;
}


@end

@implementation DestinationViewController

- (void)creatSwipeGesture {
    UISwipeGestureRecognizer *swipeGestureRecognizerLeft = [[UISwipeGestureRecognizer alloc] init];
    [swipeGestureRecognizerLeft addTarget:self action:@selector(gestureRecognizerHandleLeft:)];
    [swipeGestureRecognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeGestureRecognizerLeft];
    
    UISwipeGestureRecognizer *swipeGestureRecognizerRight = [[UISwipeGestureRecognizer alloc] init];
    [swipeGestureRecognizerRight addTarget:self action:@selector(gestureRecognizerHandleRight:)];
    [swipeGestureRecognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeGestureRecognizerRight];
    
}

- (void)gestureRecognizerHandleLeft:(UISwipeGestureRecognizer *)gesture {
    CGRect tableViewFrame = _tabelView.frame;
    tableViewFrame.origin.x = 0;
    CGRect frame = _drawerView.frame;
    frame.origin.x = -100;
    [UIView animateWithDuration:0.5 animations:^{
        _tabelView.frame = tableViewFrame;
        _drawerView.frame = frame;
    }];
}
- (void)gestureRecognizerHandleRight:(UISwipeGestureRecognizer *)gesture {
    CGRect tableViewFrame = _tabelView.frame;
    tableViewFrame.origin.x = 100;
    CGRect frame = _drawerView.frame;
    frame.origin.x = 0;
    [UIView animateWithDuration:0.5 animations:^{
        _tabelView.frame = tableViewFrame;
        _drawerView.frame = frame;
    }];
    
}

- (void)createDrawerView {
    _selectString = @"热门";
    _drawerView = [[UIView alloc] initWithFrame:CGRectMake(-100, 0, 100, ScreenSize.height - 64)];
    _drawerView.backgroundColor = [UIColor whiteColor];
    
    UILabel * backLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, ScreenSize.height - 64)];
    backLabel.backgroundColor = [UIColor lightGrayColor];
    backLabel.alpha = 0.5;
    [_drawerView addSubview:backLabel];
    
    NSArray * countryNames = @[@"热门",@"亚洲",@"欧洲",@"北美洲",@"南美洲",@"大洋洲",@"非洲",@"南极洲"];
    for (int i = 0; i < countryNames.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 61 * i, 100, 60);
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:countryNames[i] forState:UIControlStateNormal];
        
        UIImageView * lineView = [[UIImageView alloc] initWithFrame:CGRectMake(5, (60 + 1) * i, 90, 1)];
        lineView.image = [UIImage imageNamed:@"cut_off_rule"];
        [_drawerView addSubview:lineView];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        button.tag = 101 + i;
        [button addTarget:self action:@selector(drawerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_drawerView addSubview:button];
    }
    [self.view addSubview:_drawerView];
}

- (void)drawerButtonClick:(UIButton *)button {
    [_hotCountryArr removeAllObjects];
    [_otherCountryArr removeAllObjects];
    
    _selectString = button.currentTitle;
    
    for (DestionationPlaceModel * model in _dataArr) {
        if ([model.catename isEqualToString:_selectString]) {
            NSArray * countrylist = model.countrylist;
            for (NSDictionary * countryliseDict in countrylist) {
                if ([_selectString isEqualToString:@"热门"]) {
                    DestionationOtherModel * otherModel = [[DestionationOtherModel alloc] init];
                    [otherModel setValuesForKeysWithDictionary:countryliseDict];
                    [_otherCountryArr addObject:otherModel];
                } else {
                    DestinationModel * othModel = [[DestinationModel alloc] init];
                    [othModel setValuesForKeysWithDictionary:countryliseDict];
                    [_otherCountryArr addObject:othModel];
                }
            }
            NSArray * hotlist = model.hotcountrylist;
            for (NSDictionary * hotDict in hotlist) {
                DestinationModel * model = [[DestinationModel alloc] init];
                [model setValuesForKeysWithDictionary:hotDict];
                [_hotCountryArr addObject:model];
            }
        }
    }
    [_tabelView reloadData];
}

- (void)createTableView {
    _hotCountryArr = [[NSMutableArray alloc] init];
    _otherCountryArr = [[NSMutableArray alloc] init];
    
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - 64) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    [self.view addSubview:_tabelView];
}

#pragma mark - POST

//client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786515&lon=113.671502
- (void)addTaskWithUrl:(NSString *)url finished:(SEL)selector {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setObject:url forKey:url];
    NSDictionary *parameters = @{@"client_id":@"qyer_android",@"client_secret":@"9fcaae8aefc4f9ac4915",@"v":@"1",@"track_deviceid":@"357474045959836",@"track_app_version":@"6.0",@"track_app_channel":@"360m"};
    [_manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_currentTask setObject:url forKey:url];
        [self performSelector:selector withObject:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_currentTask setObject:url forKey:url];
        NSLog(@"%@:%@",[self class],error);
    }];
}

- (void)receivePostResponse:(id)responseObject {
    NSArray * arr = responseObject[@"data"];
    for (NSDictionary * dict in arr) {
        DestionationPlaceModel * model = [[DestionationPlaceModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        
        if ([model.catename isEqualToString:@"热门"]) {
            NSArray * countryList = model.countrylist;
            for (NSDictionary * countryListDict in countryList) {
                DestionationOtherModel * model = [[DestionationOtherModel alloc] init];
                [model setValuesForKeysWithDictionary:countryListDict];
                [_otherCountryArr addObject:model];
            }
            NSArray * hotList = model.hotcountrylist;
            for (NSDictionary * hotDict in hotList) {
                DestinationModel * model = [[DestinationModel alloc] init];
                [model setValuesForKeysWithDictionary:hotDict];
                [_hotCountryArr addObject:model];
            }
        }
        [_dataArr addObject:model];
    }
    [_tabelView reloadData];
}

- (void)setNavigation {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setBackgroundImage:[UIImage imageNamed:@"btn_reader_catalog"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(readerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)readerButtonClick:(UIButton *)btn {
    CGRect tableViewFrame = _tabelView.frame;
    
    if (tableViewFrame.origin.x == 100) {
        tableViewFrame.origin.x = 0;
        CGRect frame = _drawerView.frame;
        frame.origin.x = -100;
        [UIView animateWithDuration:0.5 animations:^{
            _tabelView.frame = tableViewFrame;
            _drawerView.frame = frame;
        }];
    } else {
        tableViewFrame.origin.x = 100;
        CGRect frame = _drawerView.frame;
        frame.origin.x = 0;
        [UIView animateWithDuration:0.5 animations:^{
            _tabelView.frame = tableViewFrame;
            _drawerView.frame = frame;
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createTableView];
    [self addTitleViewWithTitle:@"目的地"];
    [self setNavigation];
    [self createDrawerView];
    [self creatSwipeGesture];
    [self addTaskWithUrl:Destion_URL finished:@selector(receivePostResponse:)];
}

- (void)countryImageButtonClick:(UIButton *)button {
    DestionDetailViewController * vc = [[DestionDetailViewController alloc] init];
    vc.pid = [NSString stringWithFormat:@"%ld",button.tag];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DestionationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DestionationCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DestionationCell" owner:self options:nil]lastObject];
    }
    if (indexPath.section == 0) {
        DestinationModel * model1 = _hotCountryArr[indexPath.row * 2];
        [cell.placeImageView1 sd_setImageWithURL:[NSURL URLWithString:model1.photo] placeholderImage:[UIImage imageNamed:@"Board_Normal"]];
        //////////设置第一分区  imageView1 热门国家的点击事件
        cell.placeImageButton1.tag = [model1.pid intValue];
        [cell.placeImageButton1 addTarget:self action:@selector(countryImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.placeCount1.text = model1.count;
        cell.placeCount2.text = model1.catename;
        cell.englishNameLabel1.text = model1.catename_en;
        
        DestinationModel * model2 = nil;
        if (indexPath.row * 2 + 1 < _hotCountryArr.count) {
            model2 = _hotCountryArr[indexPath.row * 2 + 1];
        }
        if (indexPath.row * 2 + 1 < _hotCountryArr.count) {
            [cell.placeImageView2 sd_setImageWithURL:[NSURL URLWithString:model2.photo] placeholderImage:[UIImage imageNamed:@"Board_Normal"]];
            ///////////////设置第一分区 imageView2 热门国家点击事件
            cell.placeImageButton2.tag = [model2.pid intValue];
            [cell.placeImageButton2 addTarget:self action:@selector(countryImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.placeCount2.text = model2.count;
            cell.placeNameLabel2.text = model2.catename;
            cell.englishNameLabel2.text = model2.catename_en;
        } else {
            cell.placeImageView2.image = nil;
            cell.placeCount2.text = nil;
            cell.placeNameLabel2.text = nil;
            cell.englishNameLabel2.text = nil;
        }
    } else if (indexPath.section == 1) {
        if ([_selectString isEqualToString:@"热门"]) {
            DestionationOtherModel * model1 = _otherCountryArr[indexPath.row * 2];
            [cell.placeImageView1 sd_setImageWithURL:[NSURL URLWithString:model1.photo] placeholderImage:[UIImage imageNamed:@"Board_Normal"]];
            
            ///////////////设置热门   第二分区   imageView1 热门国家点击事件
            cell.placeImageButton1.tag = [model1.pid intValue];
            [cell.placeImageButton1 addTarget:self action:@selector(countryImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.placeCount1.text = [model1.count stringValue];
            cell.placeNameLabel1.text = model1.catename;
            cell.englishNameLabel1.text = model1.catename_en;
            
            DestionationOtherModel * model2 = nil;
            if (indexPath.row * 2 + 1 < _otherCountryArr.count) {
                model2 = _otherCountryArr[indexPath.row * 2 + 1];
            }
            if (indexPath.row * 2 + 1 < _otherCountryArr.count) {
                [cell.placeImageView2 sd_setImageWithURL:[NSURL URLWithString:model2.photo] placeholderImage:[UIImage imageNamed:@"Board_Normal"]];
                /////////设置热门 第二分区  imageView2 热门国家点击事件
                cell.placeImageButton2.tag = [model2.pid intValue];
                [cell.placeImageButton2 addTarget:self action:@selector(countryImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.placeCount2.text = [model1.count stringValue];
                cell.placeNameLabel2.text = model2.catename;
                cell.englishNameLabel2.text = model2.catename_en;
            } else {
                cell.placeImageView2.image = nil;
                cell.placeCount2.text = nil;
                cell.placeNameLabel2.text = nil;
                cell.englishNameLabel2.text = nil;
            }
            
        } else {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            }
            DestinationModel * model = _otherCountryArr[indexPath.row];
            cell.textLabel.text = model.catename;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            return cell;
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && ![_selectString isEqualToString:@"热门"]) {
        DestinationModel * model = _otherCountryArr[indexPath.row];
        DestionDetailViewController * vc = [[DestionDetailViewController alloc] init];
        vc.pid = model.pid;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && ![_selectString isEqualToString:@"热门"]) {
        return 40;
    }
    return 210;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_hotCountryArr.count) {
        if (section) {
            return @"其他国家";
        }
        return @"热门国家";
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return (_otherCountryArr.count + 1)/2;
    } else {
        return (_hotCountryArr.count + 1)/2;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
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
