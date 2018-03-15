//
//  MyImageView.m
//  Poor Travel
//
//  Created by Wang666 on 15/3/2.
//  Copyright (c) 2015年 Wang666. All rights reserved.
//

#import "MyImageView.h"

@interface MyImageView ()
@property (nonatomic,assign) id target;
@property (nonatomic,assign) SEL action;
@end

@implementation MyImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //打开用户交互
        self.userInteractionEnabled = YES;
    }
    return self;
}
//触摸屏幕调用
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([self.target respondsToSelector:self.action]) {
        [self.target performSelector:self.action withObject:self];
    }
}

- (void)addTarget:(id)target action:(SEL)action{
    self.target = target;
    self.action = action;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
