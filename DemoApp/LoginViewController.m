//
//  LoginViewController.m
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/1.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addBackButton:@"返回"];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self setNavigtionBarTransparent:NO];
}

- (void)backBtnEvent:(id)_sender{
     [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Login_Closed object:nil];
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
