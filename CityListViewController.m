//
//  CityListViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "CityListViewController.h"
#import "CityListCell.h"
#import "CityListModel.h"

#import "CityDetailViewController.h"

@interface CityListViewController ()

@end

@implementation CityListViewController

- (void)createSearchBar {

}

//client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786515&lon=113.671419&page=1&countryid=186

- (void)addTaskWithUrl:(NSString *)url finished:(SEL)selector {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setObject:url forKey:url];
    NSDictionary *parameters = @{@"client_id":@"qyer_android",@"client_secret":@"9fcaae8aefc4f9ac4915",@"v":@"1",@"track_deviceid":@"357474045959836",@"track_app_channel":@"360m",@"page":@"1",@"countryid":self.countryId};
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
        CityListModel * model = [[CityListModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        model.cityID = dict[@"id"];
        [_dataArr addObject:model];
    }
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.frame = CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - 64 - 49);
    [self addTaskWithUrl:GET_CityList_URL finished:@selector(downLoadFinished:)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CityListCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CityListCell" owner:self options:nil]lastObject];
    }
    CityListModel * model = _dataArr[indexPath.row];
    [cell.cityImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"list_defaultPNG"]];
    cell.cityNameLabel.text = model.catename;
    cell.beenNumLabel.text = model.beenstr;
    cell.contentLabel.text = model.representative;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CityListModel * model = _dataArr[indexPath.row];
    CityDetailViewController * vc = [[CityDetailViewController alloc] init];
    vc.cityId = model.cityID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 133;
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
