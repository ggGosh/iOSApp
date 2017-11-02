//
//  HJNavigtionBar.h
//  WeiKe
//
//  Created by hsmob on 14/11/29.
//  Copyright (c) 2014年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJNavigtionBar : UIView{
    UIImageView *backgroundImage;
    UILabel *titleText;
}
@property (nonatomic, strong) UIImageView* backgroundImage;
@property (nonatomic, strong) UILabel* titleText;
@property (nonatomic, strong) UIView* lineView;
@end
