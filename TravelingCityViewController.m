//
//  TravelingCityViewController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/5.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TravelingCityViewController.h"
#include "AFNetworking.h"

@interface TravelingCityViewController () {
    NSTimer * _timer;
    NSInteger _offsetY;
    UIView * bigView;
}

@end

@implementation TravelingCityViewController

- (void)addTask:(NSString *)url {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = responseObject[@"data"];
        _cityLabel.text = dict[@"cnname"];
        _cityLabel_en.text = dict[@"enname"];
        _chatRoomLabel.text = [NSString stringWithFormat:@"%@聊天室",dict[@"cnname"]];
        _peopleLabel.text = [NSString stringWithFormat:@"%@",dict[@"user_total"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@ : %@",[self class],error);
    }];
}

- (void)chatContent {
    NSArray *contentText = @[@"大家好,终于平安到达....",@"今天吃了一家牛排,肥瘦均匀",@"刚到机场准备前往市区...",@"准备肥家,大家旅行愉快!",@"附近中国大使馆在哪？",@"我在外面看夜景,好美哟！",@"没时间了,准备直接免税店",@"今天天气不错",@"还是习惯吃中餐",@"注意安全，保护好钱包",@"我早就从酒店出发啦",@"大家下一站准备去哪?"];
    
    _chatScrollView.contentSize = CGSizeMake(324, 48 * 30);
    bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 324, 48 * 30)];
    
    for (int i = 0; i < 30; i++) {
        UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 48 * i, 324, 48)];
        backView.backgroundColor = [UIColor clearColor];
        
        UIImageView * headerView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 7, 34, 34)];
        headerView.image = [UIImage imageNamed:[NSString stringWithFormat:@"HomePage_DefaultAvatar_%d",(arc4random()%19) + 1]];
        headerView.layer.masksToBounds = YES;
        headerView.layer.cornerRadius = 17;
        [backView addSubview:headerView];
        
        UILabel * chatLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 250, 48)];
        chatLabel.text = contentText[arc4random()%10 + 1];
        chatLabel.textColor = [UIColor whiteColor];
        chatLabel.font = [UIFont systemFontOfSize:13];
        [backView addSubview:chatLabel];
        
        [bigView addSubview:backView];
    }
    
    [self.chatScrollView addSubview:bigView];
}

- (void)createTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(pageUp) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate distantPast]];
}

- (void)pageUp {
    CGRect frame = bigView.frame;
    //大view出去后  重新归零y
    if (frame.origin.y < -48 * 30) {
        frame.origin.y = 0;
        bigView.frame = frame;
    } else {
        //每次调定时器方法都把大view向上挪
        frame.origin.y -= 48;
        [UIView animateWithDuration:0.5 animations:^{
            bigView.frame = frame;
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _chatView.layer.masksToBounds = YES;
    _chatView.layer.cornerRadius = 25;
    
    [self addTask:[NSString stringWithFormat:Traveling_City_URL,@"lat=35.658763&lon=139.700864"]];
    
    [self chatContent];
    [self createTimer];
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
