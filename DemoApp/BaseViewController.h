//
//  BaseViewController.h
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/1.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJNavigtionBar.h"

@interface BaseViewController : UIViewController{
    
    UIButton *backButton;
    HJNavigtionBar *navigtionBar;
    UIView *contentView;
}

@property (nonatomic, strong) UIButton* backButton;
@property (nonatomic, strong) HJNavigtionBar* navigtionBar;
@property (nonatomic, strong) UIView* contentView;

//设置导航条是否透明
-(void)setNavigtionBarTransparent:(BOOL)_transparent;
//添加返回按钮
- (void)addBackButton:(NSString *)_titleStr;
//设置返回按钮文字
-(void)setBackTitle:(NSString *)_titleStr;
-(void)backBtnEvent:(id)_sender;
@end
