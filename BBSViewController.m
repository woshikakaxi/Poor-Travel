//
//  BBSViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "BBSViewController.h"
#import "BBSCell.h"
#import "BBSModel.h"

#import "BBSSectionHeaderView.h"

#import "BBSDetailViewController.h"

@interface BBSViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout> {
    UICollectionView * _collectionView;
    NSMutableArray * _bbsSectionNameArr;
}

@end

@implementation BBSViewController

- (void)createTableView {

}

- (void)createCollectionView {
    _bbsSectionNameArr = [[NSMutableArray alloc] init];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(187, 50);
    layout.headerReferenceSize = CGSizeMake(ScreenSize.width, 40);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - 64 - 49) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"BBSCell" bundle:nil] forCellWithReuseIdentifier:@"BBSCell"];
    [_collectionView registerClass:[BBSSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self.view addSubview:_collectionView];
}

- (void)addTaskWithUrl:(NSString *)url finished:(SEL)selector {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setObject:url forKey:url];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_currentTask removeObjectForKey:url];
        [self performSelectorInBackground:selector withObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_currentTask removeObjectForKey:url];
        NSLog(@"%@ : %@",[self class],error);
    }];
}

- (void)downLoadFinished:(id)responseObject {
    NSArray * arr = responseObject[@"data"];
    for (NSDictionary * dict in arr) {
        [_bbsSectionNameArr addObject:dict[@"name"]];
        NSArray * groupArr = dict[@"group"];
        NSMutableArray * groupTempArr = [[NSMutableArray alloc] init];
        for (NSDictionary * groupDict in groupArr) {
            BBSModel * model = [[BBSModel alloc] init];
            [model setValuesForKeysWithDictionary:groupDict];
            model.groupSubId = groupDict[@"id"];
            [groupTempArr addObject:model];
        }
        [_dataArr addObject:groupTempArr];
    }
    [_collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCollectionView];
    [self addTitleViewWithTitle:@"社区"];
    [self addTaskWithUrl:BBS_URL finished:@selector(downLoadFinished:)];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BBSCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BBSCell" forIndexPath:indexPath];
    BBSModel * model = _dataArr[indexPath.section][indexPath.row];
    cell.bbsImageView.layer.masksToBounds = YES;
    cell.bbsImageView.layer.cornerRadius = 4;
    [cell.bbsImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"place_search_default"]];
    cell.titleLabel.text = model.name;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BBSModel * model = _dataArr[indexPath.section][indexPath.row];
    BBSDetailViewController * vc = [[BBSDetailViewController alloc] init];
    vc.bbsId = [model.groupSubId stringValue];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView * reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        BBSSectionHeaderView * headerView = (BBSSectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 40)];
        label.text = _bbsSectionNameArr[indexPath.section];
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:label];
        
        reusableView = headerView;
    }
    return reusableView;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenSize.width, 40);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataArr[section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
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
