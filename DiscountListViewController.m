//
//  DiscountListViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "DiscountListViewController.h"
//用的之前推荐界面 折扣按钮的cell 和 model
#import "DiscountListCell.h"
#import "QYDiscountModel.h"

#import "DiscountDetailViewController.h"

@interface DiscountListViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout> {
    UICollectionView * _collectionView;
}

@end

@implementation DiscountListViewController

- (void)createCollectionView {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(173, 200);
    layout.sectionInset = UIEdgeInsetsMake(10, 9, 0, 10);
    layout.minimumInteritemSpacing = 10;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - 64 - 49) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"DiscountListCell" bundle:nil] forCellWithReuseIdentifier:@"DiscountListCell"];
    [self.view addSubview:_collectionView];
}

//client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786395&lon=113.671399&max_id=0&product_type=0&continent_id=0&country_id=186&departure=&times=&is_show_pay=1

- (void)addTaskWithUrl:(NSString *)url finished:(SEL)selector {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setObject:url forKey:url];
    
    NSDictionary *parameters = @{@"client_id":@"qyer_android",@"client_secret":@"9fcaae8aefc4f9ac4915",@"v":@"1",@"track_deviceid":@"357474045959836",@"track_app_version":@"6.0",@"track_app_channel":@"360m",@"country_id":self.countryId};
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCollectionView];
    [self addTaskWithUrl:GET_DiscountList_URL finished:@selector(downLoadFinished:)];
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
