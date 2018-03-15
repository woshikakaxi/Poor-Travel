//
//  TabBarController.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "TabBarController.h"
#import "ParentViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self createAnimate];
    [self createViewControllers];
    [self createTabBarController];
}

//添加开机动画效果
- (void)createAnimate {
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    imageView.image = [UIImage imageNamed:@"Default-1104h@3x"];
    [self.view addSubview:imageView];
    
    CGAffineTransform transform = CGAffineTransformScale(imageView.transform, 2.007, 2.007);
    [UIView animateWithDuration:3 animations:^{
        [imageView setTransform:transform];
        imageView.alpha = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}

- (void)createViewControllers {
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    //NSArray * titleArr = @[@"推荐",@"目的地",@"社区",@"我的",@"旅途中"];
    NSArray * controllerArr = @[@"RecommendViewController",@"DestinationViewController",@"BBSViewController",@"MineViewController",@"TravellingViewController"];
    for (int i = 0; i < controllerArr.count; i++) {
        Class cls = NSClassFromString(controllerArr[i]);
        ParentViewController * con = [[cls alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:con];
        //con.title = titleArr[i];
        [arr addObject:nav];
    }
    self.viewControllers = arr;
}

- (void)createTabBarController {
    self.tabBar.hidden = YES;
    
    UIView * travelTabBar = [[UIView alloc] initWithFrame:CGRectMake(0, [LZXHelper getScreenSize].height - 49, [LZXHelper getScreenSize].width, 49)];
    travelTabBar.userInteractionEnabled = YES;
    travelTabBar.tag = 8001;
    travelTabBar.backgroundColor = [UIColor whiteColor];
    
    NSArray * buttonArr = @[@"TabBar_Feature",@"TabBar_Place",@"TabBar_BBS",@"TabBar_Mine",@"Recommend_Earth_Loading_1"];
    for (int i = 0; i < buttonArr.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(3 + (64+13) * i, 0, 64, 49);
        [btn setBackgroundImage:[UIImage imageNamed:buttonArr[i]] forState:UIControlStateNormal];
        if (i == 0) {
            btn.selected = YES;
        }
        if (i < buttonArr.count - 1) {
            [btn setBackgroundImage:[UIImage imageNamed:[buttonArr[i] stringByAppendingString:@"_Highlight"]] forState:UIControlStateSelected];
        }
        btn.tag = 5001 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [travelTabBar addSubview:btn];
    }
    [self.view addSubview:travelTabBar];
}

- (void)btnClick:(UIButton *)btn {
    UIView * view = (UIView *)[self.view viewWithTag:8001];
    for (UIView * btnView in view.subviews) {
        if ([btnView isKindOfClass:[UIButton class]]) {
            ((UIButton *)btnView).selected = NO;
        }
    }
    btn.selected = YES;
    self.selectedIndex = btn.tag - 5001;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self createAnimate];
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
