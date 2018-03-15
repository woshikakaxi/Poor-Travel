//
//  ParentViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "ParentViewController.h"

@interface ParentViewController ()

@end

@implementation ParentViewController

- (void)dealloc {
    [_manager.operationQueue cancelAllOperations];
    [_currentTask removeAllObjects];
}

- (void)dataInit {
    _dataArr = [[NSMutableArray alloc] init];
    _manager = [AFHTTPRequestOperationManager manager];
}

- (void)addTaskWithUrl:(NSString *)url finished:(SEL)selector {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setValue:url forKey:url];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
        [self performSelector:selector withObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
        NSLog(@"%@ : %@",[self class],error);
    }];
}

- (void)addPostWithUrl:(NSString *)url finished:(SEL)selector {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setObject:url forKey:url];
    NSDictionary * parameters = @{@"client_id":@"qyer_android",@"client_secret":@"9fcaae8aefc4f9ac4915",@"v":@"1",@"track_deviceid":@"357474045959836",@"track_app_version":@"6.0",@"track_app_channel":@"360m"};
    [_manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_currentTask setObject:url forKey:url];
        [self performSelector:selector withObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_currentTask setObject:url forKey:url];
        NSLog(@"%@ : %@",[self class],error);
    }];
}

- (void)downLoadFinished:(id)responseObject {

}

- (void)creatRefreshing {

}

- (void)endRefreshing {

}

- (void)addTitleViewWithTitle:(NSString *)title {
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
}

- (void)addItemWithCustomView:(NSArray *)customView isLeft:(BOOL)isLeft {
    NSMutableArray * items = [[NSMutableArray alloc] init];
    for (int i = 0; i < customView.count; i++) {
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:customView[i]];
        [items addObject:item];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_head"] forBarMetrics:UIBarMetricsDefault];
    [self dataInit];
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
