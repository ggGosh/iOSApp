//
//  ViewController.h
//  DemoApp
//
//  Created by 谭学勇 on 2017/10/26.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarViewController.h"

#define Notification_Login_Closed @"Notification_Login_Closed"

@interface ViewController : UINavigationController

@property (nonatomic, strong, readonly) MainTabBarViewController *mainTabBarViewController;
+(ViewController *)getMainViewController;
- (void)showLogin:(NSInvocation *)invocation animated:(BOOL)animated;
@end

