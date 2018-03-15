//
//  BBSDetailSubParentView.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "BBSDetailSubCell.h"
#import "BBSDetailSubModel.h"

@interface BBSDetailSubParentView : UIView <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    AFHTTPRequestOperationManager *_bbsManager;
    NSMutableArray *_dataArr;
    BOOL _isPullRefresh;
    BOOL _isLoadMore;
    NSInteger *_currentPage;
    NSMutableDictionary *_currentTask;
}
@property (nonatomic,copy) NSString *bbsId;


- (id)initWithIDString:(NSString *)bbsId type:(NSString *)type;
- (void)addTaskWithUrl:(NSString *)url finished:(SEL)selector;
- (void)downloadFinished:(id)responseObject;
- (void)creatRefreshing;
- (void)endRefresh;


@end
