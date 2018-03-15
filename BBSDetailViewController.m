//
//  BBSDetailViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/4.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "BBSDetailViewController.h"
#import "BBSDetailHeaderView.h"

#import "BBSDetailSubParentView.h"

@interface BBSDetailViewController () <UIScrollViewDelegate> {
    BBSDetailHeaderView * _headerView;
    UIScrollView * _scrollView;
}

@end

@implementation BBSDetailViewController

- (void)createHeaderView {
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"BBSDetailHeaderView" owner:self options:nil]lastObject];
    _headerView.frame = CGRectMake(0, 0, 375, 118);
    
    [_headerView.allButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.latestButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.digestButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.moreButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_headerView];
}

- (void)btnClick:(UIButton *)button {
    //NSLog(@"+++++%ld",button.tag);
    CGFloat offsetX = ScreenSize.width * (button.tag - 201);
    _scrollView.contentOffset = CGPointMake(offsetX, 0);
    CGRect frame = _headerView.eventImageView.frame;
    frame.origin.x = 94 * (button.tag - 201);
    [UIView animateWithDuration:0.5 animations:^{
        _headerView.eventImageView.frame = frame;
    }];
    
}

- (void)createScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 118, ScreenSize.width, ScreenSize.height - 118 - 64 - 49)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(ScreenSize.width * 4, ScreenSize.height - 118 - 64 - 49);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.directionalLockEnabled = YES;
    [self.view addSubview:_scrollView];
}

- (void)addTaskWithUrl:(NSString *)url finished:(SEL)selector {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setObject:url forKey:url];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
        [self performSelectorInBackground:selector withObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
        NSLog(@"%@ : %@",[self class],error);
    }];
}

- (void)downLoadFinished:(id)responseObject {
    NSDictionary * dict = responseObject[@"data"];
    [_headerView.bbsImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"photo"]] placeholderImage:[UIImage imageNamed:@"place_search_default"]];
    _headerView.titleLabel.text = dict[@"name"];
    _headerView.inviationCountLabel.text = [NSString stringWithFormat:@"%@个帖子",[dict[@"total"] stringValue]];
}

- (void)fillScrollView {
    NSArray * typeArr = @[@"all",@"new",@"digest",@""];
    NSArray * detailViewControllersNames = @[@"BBSDetailSubAllView",@"BBSDetailSubLatestView",@"BBSDetailSubDigestView",@"BBSDetailSubMoreView"];
    
    for (int i = 0; i < detailViewControllersNames.count; i++) {
        Class cls = NSClassFromString(detailViewControllersNames[i]);
        BBSDetailSubParentView * bbsView = [[cls alloc] initWithIDString:self.bbsId type:typeArr[i]];
        
        bbsView.frame = CGRectMake(ScreenSize.width * i, 0, ScreenSize.width, ScreenSize.height - 118 - 64 - 49);
        [_scrollView addSubview:bbsView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createScrollView];
    [self createHeaderView];
    
    [self addTaskWithUrl:[NSString stringWithFormat:BBS_ItemHeaderDetail_URL,_bbsId] finished:@selector(downLoadFinished:)];
    [self fillScrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _scrollView) {
        CGRect frame = _headerView.eventImageView.frame;
        frame.origin.x = scrollView.contentOffset.x * 93 / ScreenSize.width;
        
        [UIView animateWithDuration:0.5 animations:^{
            _headerView.eventImageView.frame = frame;
        }];
    }
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
