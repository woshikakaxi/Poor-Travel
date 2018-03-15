//
//  StarLevelView.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/3.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "StarLevelView.h"

@interface StarLevelView () {
    //背景视图
    UIImageView *_backImageView;
    //前景图片视图
    UIImageView *_foreImageView;
}

@end

@implementation StarLevelView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self createView];
    }
    return self;
}

- (void)createView {
    _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 23)];
    _backImageView.image = [UIImage imageNamed:@"StarsBackground"];
    //设置内容模式
    _backImageView.contentMode = UIViewContentModeLeft;
    //先粘贴的在下面
    [self addSubview:_backImageView];
    
    //前景  在背景的上面
    _foreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 23)];
    _foreImageView.image = [UIImage imageNamed:@"StarsForeground"];
    //设置内容模式
    _foreImageView.contentMode = UIViewContentModeLeft;
    
    //允许_foreImageView的内容图片 裁剪
    //图片超出_foreImageView的范围 裁剪
    _foreImageView.clipsToBounds = YES;
    
    //先粘贴的在下面
    [self addSubview:_foreImageView];
}
- (void)setStarLevel:(double)level {
    //改变前景的frame 的宽
    _foreImageView.frame = CGRectMake(0, 0, _backImageView.frame.size.width*(level/5.0), 23);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
