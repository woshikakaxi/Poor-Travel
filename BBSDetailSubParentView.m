//
//  BBSDetailSubParentView.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "BBSDetailSubParentView.h"

@implementation BBSDetailSubParentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [_bbsManager.operationQueue cancelAllOperations];
    [_currentTask removeAllObjects];
}

- (id)initWithIDString:(NSString *)bbsId type:(NSString *)type {
    if (self = [super init]) {
        [self createTableView];
        
        [self addTaskWithUrl:[NSString stringWithFormat:BBS_ItemDetail_URL,type,bbsId,1] finished:@selector(downloadFinished:)];
    }
    return self;
}

- (void)createTableView {
    _dataArr = [[NSMutableArray alloc] init];
    _bbsManager = [AFHTTPRequestOperationManager manager];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - 118 - 64 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
}

- (void)addTaskWithUrl:(NSString *)url finished:(SEL)selector {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setObject:url forKey:url];
    [_bbsManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
        [self performSelectorInBackground:selector withObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
        NSLog(@"%@ : %@",[self class],error);
    }];
}

- (void)downloadFinished:(id)responseObject {
    NSDictionary * dataDict = responseObject[@"data"];
    NSArray * entryArr = dataDict[@"entry"];
    for (NSDictionary * dict in entryArr) {
        BBSDetailSubModel * model = [[BBSDetailSubModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [_dataArr addObject:model];
    }
    [_tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBSDetailSubCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BBSDetailSubCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BBSDetailSubCell" owner:self options:nil]lastObject];
    }
    BBSDetailSubModel * model = _dataArr[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.userNameLabel.text = model.username;
    cell.viewCountLabel.text = model.views;
    cell.commentCountLabel.text = model.replys;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
