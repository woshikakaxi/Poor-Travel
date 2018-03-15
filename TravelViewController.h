//
//  TravelViewController.h
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "ParentViewController.h"

@interface TravelViewController : ParentViewController <UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate> {
    UISearchBar * _searchBar;
    UITableView * _tableView;
}

- (void)creatRefreshing;
- (void)endRefreshing;
- (void)createTableView;
- (void)createSearchBar;

@end
