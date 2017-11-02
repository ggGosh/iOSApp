//
//  HJNavigtionBar.m
//  WeiKe
//
//  Created by hsmob on 14/11/29.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import "HJNavigtionBar.h"

@implementation HJNavigtionBar
@synthesize backgroundImage,titleText, lineView;
#define labelWidth 300
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init{
     self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    if(self){
        backgroundImage=[[UIImageView alloc]initWithFrame:self.frame];
        [self addSubview:backgroundImage];
        
        titleText=[[UILabel alloc]initWithFrame:CGRectMake(60, 20, ScreenWidth - 60 * 2, 44)];
        [titleText setTextAlignment:NSTextAlignmentCenter];
        [titleText setFont:[UIFont systemFontOfSize:18]];
        [titleText setTextColor:[UIColor colorFromHexCode:@"333333"]];
        [titleText setBackgroundColor:[UIColor clearColor]];
        [self addSubview:titleText];
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, ScreenWidth, 0.5)];
        lineView.backgroundColor = [UIColor colorFromHexCode:@"e0e0e0"];
        [self addSubview:lineView];
    }
    return self;
}
-(void)setFrame:(CGRect)_rect{
    [super setFrame:_rect];
    _rect.origin.x=0;
    _rect.origin.y=0;
    [backgroundImage setFrame:_rect];
}

@end
