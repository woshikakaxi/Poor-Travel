//
//  QYDiscountViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "QYDiscountViewController.h"
#import "QYDiscountModel.h"
#import "DiscountListCell.h"
#import "DiscountDetailViewController.h"
#import "SegModel.h"

@interface QYDiscountViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    UICollectionView * _collectionView;
    UIView * _customSegmentControl;
    NSDictionary * _segDataDict;
    
    NSMutableArray * _typeArr;
    NSMutableArray * _destionationArr;
    
    UITableView * _typeView;
    
    UIView * _destionationView;
    UITableView * _continentTableView;
    UITableView * _countryTableView;
    
    NSInteger _index;
}

@end

@implementation QYDiscountViewController

- (void)createTypeView {
    _typeView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, ScreenSize.width, ScreenSize.height - 64 - 40 - 49)];
    _typeView.delegate = self;
    _typeView.dataSource = self;
    [self.view addSubview:_typeView];
    [self.view sendSubviewToBack:_typeView];
    ///////////////////
    
    _destionationView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, ScreenSize.width, ScreenSize.height - 64 - 49 - 40)];
    _continentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width / 2, ScreenSize.height - 64 - 40 - 49)];
    _continentTableView.dataSource = self;
    _continentTableView.delegate = self;
    [_destionationView addSubview:_continentTableView];
    
    _countryTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenSize.width / 2, 0, ScreenSize.width / 2, ScreenSize.height - 64 - 40 - 49)];
    _countryTableView.backgroundColor = [UIColor lightGrayColor];
    _countryTableView.delegate = self;
    _countryTableView.dataSource = self;
    [_destionationView addSubview:_countryTableView];
    
    [self.view addSubview:_destionationView];
    [self.view sendSubviewToBack:_destionationView];
    ///////////////
}

- (void)createCustomSegmentControl {
    _segDataDict = [[NSMutableDictionary alloc] init];
    _typeArr = [[NSMutableArray alloc] init];
    _destionationArr = [[NSMutableArray alloc] init];
    
    _customSegmentControl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 40)];
    _customSegmentControl.backgroundColor = [UIColor whiteColor];
    //list_tab_left 80 42
    NSArray * names = @[@"折扣类型",@"出发地",@"目的地",@"旅行时间"];
    for (int i = 0; i < names.count; i++) {
        UIButton * btn = [UIButton buttonWithType: UIButtonTypeSystem];
        btn.frame = CGRectMake((80 + 18) * i, 0, 80, 40);
        [btn setTitle:names[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"list_tab_left"] forState:UIControlStateNormal];
        btn.tag = 301 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_customSegmentControl addSubview:btn];
        
        UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake((80 + 12) * i, 5, 1, 30)];
        lineLabel.backgroundColor = [UIColor darkGrayColor];
        [_customSegmentControl addSubview:lineLabel];
    }
    [self.view addSubview:_customSegmentControl];
}

- (void)btnClick:(UIButton *)button {
    switch (button.tag) {
        case 301:
        {
            _index = 301;
            [_typeArr removeAllObjects];
            NSArray * arr = _segDataDict[@"type"];
            for (NSDictionary * dict in arr) {
                SegModel * model = [[SegModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                model.typeId = dict[@"id"];
                [_typeArr addObject:model];
            }
            [_typeView reloadData];
            [self.view bringSubviewToFront:_typeView];
        }
            break;
            
            case 302:
        {
            _index = 302;
            [_typeArr removeAllObjects];
            NSArray * arr = _segDataDict[@"departure"];
            for (NSDictionary * dict in arr) {
                SegModel * model = [[SegModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [_typeArr addObject:model];
            }
            [_typeView reloadData];
            [self.view bringSubviewToFront:_typeView];
        }
            break;
            
            case 303:
        {
            _index = 303;
            [_typeArr removeAllObjects];
            [self.view sendSubviewToBack:_typeView];
            NSArray *arr = _segDataDict[@"poi"];
            for (NSDictionary *dict in arr) {
                SegModel *model = [[SegModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [_typeArr addObject:model];
            }
            [_continentTableView reloadData];
            [self.view bringSubviewToFront:_destionationView];
        }
            break;
            
            case 304:
        {
            _index = 304;
            
            [_typeArr removeAllObjects];
            NSArray *arr = _segDataDict[@"times_drange"];
            for (NSDictionary *dict in arr) {
                SegModel *model = [[SegModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                model.timeDescription = dict[@"description"];
                [_typeArr addObject:model];
            }
            [_typeView reloadData];
            [self.view bringSubviewToFront:_typeView];
        }
            break;
            
        default:
            break;
    }
}

- (void)createCollectionView {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(173, 200);
    layout.sectionInset = UIEdgeInsetsMake(10, 9, 0, 10);
    layout.minimumInteritemSpacing = 10;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, ScreenSize.width, ScreenSize.height - 64 - 49) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"DiscountListCell" bundle:nil] forCellWithReuseIdentifier:@"DiscountListCell"];
    [self.view addSubview:_collectionView];
}
//client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786447&lon=113.67144&max_id=0&product_type=0&continent_id=0&country_id=0&departure=&times=&is_show_pay=1
- (void)addPostTaskWithUrl:(NSString *)url finished:(SEL)selector {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setObject:url forKey:url];
    NSDictionary *parameters = @{@"client_id":@"qyer_android",@"client_secret":@"9fcaae8aefc4f9ac4915",@"v":@"1",@"track_deviceid":@"357474045959836",@"track_app_channel":@"360m",@"max_id":@"0",@"product_type":self.product_type,@"departure":self.departure,@"continent_id":self.continent_id,@"country_id":self.country_id,@"times":self.times,@"is_show_pay":@"1"};
    [_manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
        [self performSelectorInBackground:selector withObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
        NSLog(@"%@ : %@",[self class],error);
    }];
}

- (void)downLoadFinished:(id)responseObject {
    NSArray * arr = responseObject[@"data"];
    for (NSDictionary * dict in arr) {
        QYDiscountModel * model = [[QYDiscountModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        model.discountId = dict[@"id"];
        [_dataArr addObject:model];
    }
    [_collectionView reloadData];
}

- (void)addTaskWithUrl:(NSString *)url finish:(SEL)selector {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setObject:url forKey:url];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
        [self performSelector:selector withObject:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
        NSLog(@"%@:%@",[self class],error);
    }];
}

- (void)loadFinished:(id)responseObject {
    _segDataDict = responseObject[@"data"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCollectionView];
    [self createCustomSegmentControl];
    [self createTypeView];
    [self addTitleViewWithTitle:@"穷游折扣"];
    self.product_type = @"0";
    self.departure = @"";
    self.continent_id = @"0";
    self.country_id = @"0";
    self.times = @"";
    [self addPostTaskWithUrl:QYDiscount_URL finished:@selector(downLoadFinished:)];
    [self addTaskWithUrl:GET_AllCategory_URL finish:@selector(loadFinished:)];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DiscountListCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DiscountListCell" forIndexPath:indexPath];
    QYDiscountModel * model = _dataArr[indexPath.row];
    [cell.discountImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"list_defaultPNG"]];
    cell.titleLabel.text = model.title;
    cell.timeLineLabel.text = model.end_date;
    
    NSString * dismark = model.price;
    NSArray * arr = [dismark componentsSeparatedByString:@"</"];
    NSString * str = arr[0];
    NSString * priceStr = [str substringFromIndex:4];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@元起",priceStr];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    QYDiscountModel * model = _dataArr[indexPath.row];
    DiscountDetailViewController * vc = [[DiscountDetailViewController alloc] init];
    vc.discountID = model.discountId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _typeView) {
        [_dataArr removeAllObjects];
        SegModel * model = _typeArr[indexPath.row];
        switch (_index) {
            case 301:
            {
                self.product_type = model.typeId;
                [self addPostTaskWithUrl:QYDiscount_URL finished:@selector(downLoadFinished:)];
                
                UIButton * btn = (UIButton *)[_customSegmentControl viewWithTag:_index];
                [btn setTitle:model.catename forState:UIControlStateNormal];
                [self.view sendSubviewToBack:_typeView];
                [self.view sendSubviewToBack:_continentTableView];
                [self.view sendSubviewToBack:_countryTableView];
            }
                break;
                
                case 302:
            {
                self.departure = model.city;
                [self addPostTaskWithUrl:QYDiscount_URL finished:@selector(downLoadFinished:)];
                UIButton *button = (UIButton *)[_customSegmentControl viewWithTag:_index];
                [button setTitle:model.city_des forState:UIControlStateNormal];
                [self.view sendSubviewToBack:_typeView];
                [self.view sendSubviewToBack:_continentTableView];
                [self.view sendSubviewToBack:_countryTableView];
            }
                break;
                
                case 303:
            {
            }
                break;
                
                case 304:
            {
                self.departure = model.times;
                [self addPostTaskWithUrl:QYDiscount_URL finished:@selector(downLoadFinished:)];
                UIButton *button = (UIButton *)[_customSegmentControl viewWithTag:_index];
                [button setTitle:model.timeDescription forState:UIControlStateNormal];
                [self.view sendSubviewToBack:_typeView];
                [self.view sendSubviewToBack:_continentTableView];
                [self.view sendSubviewToBack:_countryTableView];
            }
                break;
                
            default:
                break;
        }
    } else if (tableView == _continentTableView) {
        [_destionationArr removeAllObjects];
        SegModel *model = _typeArr[indexPath.row];
        self.continent_id = [model.continent_id stringValue];
        NSArray *arr = model.country;
        for (NSDictionary *dict in arr) {
            SegModel *sModel = [[SegModel alloc] init];
            [sModel setValuesForKeysWithDictionary:dict];
            [_destionationArr addObject:sModel];
        }
        
        [_countryTableView reloadData];
    } else if (tableView == _countryTableView) {
        SegModel *model = _destionationArr[indexPath.row];
        self.country_id = model.country_id;
        UIButton *button = (UIButton *)[_customSegmentControl viewWithTag:303];
        [button setTitle:model.country_name forState:UIControlStateNormal];
        [self addPostTaskWithUrl:QYDiscount_URL finished:@selector(downLoadFinished:)];
        [self.view sendSubviewToBack:_destionationView];
        [self.view sendSubviewToBack:_typeView];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    if (tableView == _typeView) {
        SegModel * model = _typeArr[indexPath.row];
        switch (_index) {
            case 301:
                cell.textLabel.text = model.catename;
                break;
                
            case 302:
                cell.textLabel.text = model.city_des;
                break;
                
                case 303:
                break;
                
                case 304:
                cell.textLabel.text = model.timeDescription;
                break;
                
            default:
                break;
        }
    } else if (tableView == _continentTableView) {
        SegModel * model = _typeArr[indexPath.row];
        cell.textLabel.text = model.continent_name;
    } else if (tableView == _countryTableView) {
        SegModel * model = _destionationArr[indexPath.row];
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.textLabel.text = model.country_name;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _typeView || tableView == _continentTableView) {
        return _typeArr.count;
    } else {
        return _destionationArr.count;
    }
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
