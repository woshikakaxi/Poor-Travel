//
//  MguideDetailViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "MguideDetailViewController.h"
#import "MguideDetailCell.h"
#import "MguideHeaderView.h"
#import "StarLevelView.h"
#import "MguideDetailModel.h"

@interface MguideDetailViewController () <UITableViewDataSource,UITableViewDelegate> {
    UITableView * _tableView;
}

@end

@implementation MguideDetailViewController

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)createHeaderViewObject:(id)responseObject {
    NSDictionary * dict = responseObject[@"data"];
    MguideHeaderView * headerView = [[[NSBundle mainBundle] loadNibNamed:@"MguideHeaderView" owner:self options:nil]lastObject];
    [headerView.headerImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"photo"]] placeholderImage:[UIImage imageNamed:@"default_plan_back"]];
    headerView.placeNumLabel.text = [NSString stringWithFormat:@"%@个旅行地",dict[@"count"]];
    headerView.userHeaderImageView.layer.masksToBounds = YES;
    headerView.userHeaderImageView.layer.cornerRadius = 25;
    [headerView.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"avatar"]] placeholderImage:[UIImage imageNamed:@"communityDefault"]];
    headerView.userNameLabel.text = dict[@"username"];
    headerView.titleLabel.text = dict[@"title"];
    
    headerView.headerContentLabel.text = dict[@"description"];
    CGFloat headerContentLabelHeight = [LZXHelper textHeightFromTextString:dict[@"description"] width:359 fontSize:13];
    CGRect frame = headerView.headerContentLabel.frame;
    frame.size.height = headerContentLabelHeight;
    headerView.headerContentLabel.frame = frame;
    
    CGRect headFrame = headerView.frame;
    headFrame.size.height = headFrame.size.height + headerContentLabelHeight;
    headerView.frame = headFrame;
    
    UIView * view = _tableView.tableHeaderView;
    view.frame = CGRectMake(0, 0, ScreenSize.width, headFrame.size.height);
    _tableView.tableHeaderView = view;
    _tableView.tableHeaderView = headerView;
}

- (void)addTaskWithUrl:(NSString *)url finish:(SEL)selector {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setObject:url forKey:url];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_currentTask removeObjectForKey:url];
        [self createHeaderViewObject:responseObject];
        [self performSelectorInBackground:selector withObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_currentTask removeObjectForKey:url];
        NSLog(@"%@ : %@",[self class],error);
    }];
}

- (void)downLoadFinished:(id)responseObject {
    NSDictionary * dict = responseObject[@"data"];
    
    NSArray * arr = dict[@"pois"];
    for (NSDictionary * poisDict in arr) {
        MguideDetailModel * model = [[MguideDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:poisDict];
        model.mguid = poisDict[@"id"];
        model.descriptionContent = poisDict[@"description"];
        [_dataArr addObject:model];
    }
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self createTableView];
    NSString * url = [NSString stringWithFormat:Mguide_Detail_URL,self.mguideID];
    [self addTaskWithUrl:url finish:@selector(downLoadFinished:)];
}

/*
 @property (weak, nonatomic) IBOutlet UIImageView *mguideImageView;
 @property (weak, nonatomic) IBOutlet UILabel *englishNameLabel;
 @property (weak, nonatomic) IBOutlet UILabel *chineseNameLabel;
 @property (weak, nonatomic) IBOutlet StarLevelView *starLevelView;
 @property (weak, nonatomic) IBOutlet UILabel *mguideContentLabel;
 @property (weak, nonatomic) IBOutlet UIButton *mguideCollectionButton;
 */
- (void)showDataWithModel:(MguideDetailModel *)model cell:(MguideDetailCell *)cell {
    [cell.mguideImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"default_plan_back"]];
    cell.englishNameLabel.text = model.englishname;
    cell.chineseNameLabel.text = model.chinesename;
    [cell.starLevelView setStarLevel:[model.recommandstar doubleValue]];
    cell.mguideContentLabel.text = model.descriptionContent;
    
    CGFloat mguideContentLabelHeight = [LZXHelper textHeightFromTextString:model.descriptionContent width:359 fontSize:13];
    CGRect frame = cell.mguideContentLabel.frame;
    frame.size.height = mguideContentLabelHeight;
    cell.mguideContentLabel.frame = frame;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MguideDetailCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"MguideDetailCell" owner:self options:nil]lastObject];
    MguideDetailModel * model = _dataArr[indexPath.row];
    [self showDataWithModel:model cell:cell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MguideDetailModel * model = _dataArr[indexPath.row];
    CGFloat mguideContentLabelHeight = [LZXHelper textHeightFromTextString:model.descriptionContent width:359 fontSize:13];
    
    return 250 + mguideContentLabelHeight;
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
