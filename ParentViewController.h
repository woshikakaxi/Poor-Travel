//
//  ParentViewController.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface ParentViewController : UIViewController {
    NSMutableArray * _dataArr;
    AFHTTPRequestOperationManager * _manager;
    BOOL _isPullRefreshing;
    BOOL _isLoadMore;
    NSInteger _currentPage;
    NSMutableDictionary * _currentTask;
}

- (void)addPostWithUrl:(NSString *)url finished:(SEL)selector;
- (void)addTaskWithUrl:(NSString *)url finished:(SEL)selector;
- (void)downLoadFinished:(id)responseObject;


- (void)addTitleViewWithTitle:(NSString *)title;
- (void)addItemWithCustomView:(NSArray *)customViews isLeft:(BOOL)isLeft;


- (void)creatRefreshing;
- (void)endRefreshing;
@end
