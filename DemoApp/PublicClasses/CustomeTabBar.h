//
//  CustomeTabBar.h
//  DemoApp
//
//  Created by 谭学勇 on 2017/10/27.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomeTabBar;
@protocol ZTTabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickPlusButton:(CustomeTabBar *)tabBar;

@end

@interface CustomeTabBar : UITabBar

@property (nonatomic, weak) id<ZTTabBarDelegate> myDelegate;

@end
