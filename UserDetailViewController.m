//
//  UserDetailViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/3.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "AFNetworking.h"

@interface UserDetailViewController () <UIScrollViewDelegate> {
    NSMutableDictionary * _currentTask;
    AFHTTPRequestOperationManager * _manager;
}

@end

@implementation UserDetailViewController

- (void)dataInit {
    _currentTask = [[NSMutableDictionary alloc] init];
    _manager = [AFHTTPRequestOperationManager manager];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        CGPoint point = scrollView.contentOffset;
        if (point.y < - 15) {
            CGAffineTransform newTransform = CGAffineTransformScale(self.userBackImageView.transform, 1.007, 1.007);
            [self.userBackImageView setTransform:newTransform];
        } else {
            [UIView animateWithDuration:0.5 animations:^{
                self.userBackImageView.frame = CGRectMake(0, 0, ScreenSize.width, 240);
            }];
        }
    }
}

- (void)showUI {
    self.scrollView.contentSize = CGSizeMake(ScreenSize.width, 600);
    self.userHeaderButton.layer.masksToBounds = YES;
    self.userHeaderButton.layer.cornerRadius = 40;
    
    UIImage * together = [UIImage imageNamed:@"togetherGone"];
    together = [together resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
    self.togetherImageView.image = together;
}

- (void)addTaskWithUrl:(NSString *)url {
    if ([_currentTask objectForKey:url]) {
        return;
    }
    [_currentTask setValue:url forKey:url];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
        [self downloadDinished:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_currentTask removeObjectForKey:operation.request.URL.absoluteString];
    }];
}

- (void)downloadDinished:(id)responseObject {
    NSDictionary * dict = responseObject[@"data"];
    self.userNameLabel.text = dict[@"username"];
    [self.userHeaderButton sd_setBackgroundImageWithURL:[NSURL URLWithString:dict[@"avatar"]] forState:UIControlStateNormal];
    self.attentionLabel.text = [NSString stringWithFormat:@"%@关注",dict[@"follow"]];
    self.fansLabel.text = [NSString stringWithFormat:@"%@粉丝",dict[@"fans"]];
    self.footPrintLbael.text = [NSString stringWithFormat:@"%@国家 | %@城市",dict[@"together_country_total"],dict[@"together_city_total"]];
    self.wantLabel.text = [NSString stringWithFormat:@"%@国家 | %@城市",dict[@"want_counties" ],dict[@"want_cities"]];
    [self.userBackImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"cover"]] placeholderImage:[UIImage imageNamed:@"bg_detail_cover_default"]];
    
    NSString * mapUrl = [NSString stringWithFormat:Map_URL,dict[@"user_id"],dict[@"countries"]];
    [self.mapImageView sd_setImageWithURL:[NSURL URLWithString:mapUrl] placeholderImage:[UIImage imageNamed:@"bg_detail_cover_default"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInit];
    [self showUI];
    NSString * url = [NSString stringWithFormat:User_Detail_URL,self.userID];
    [self addTaskWithUrl:url];
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
