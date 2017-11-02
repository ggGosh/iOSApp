//
//  UIApplication+Addition.m
//  WMUIKit
//
//  Created by WuShiHai on 6/21/16.
//  Copyright © 2016 WeiMob. All rights reserved.
//

#import "UIApplication+Addition.h"

@implementation UIApplication (Addition)

+ (UIViewController *)displayUIViewController{
    return [self displayUIViewController:[self displayWindow].rootViewController ignorePresent:NO];
}
+ (UIViewController *)displayUIViewController:(id)currentViewController ignorePresent:(BOOL)ignorePresent{
    if ([currentViewController isKindOfClass:[UINavigationController class]]){
        return [self displayUIViewController:[[currentViewController viewControllers] lastObject] ignorePresent:ignorePresent];
    }else if ([currentViewController isKindOfClass:[UITabBarController class]]){
        return [self displayUIViewController:[currentViewController selectedViewController] ignorePresent:ignorePresent];
    }else if ([currentViewController isKindOfClass:[UIViewController class]]) {
        if (ignorePresent == NO && [currentViewController presentedViewController] != nil) {
            return [self displayUIViewController:[currentViewController presentedViewController] ignorePresent:ignorePresent];
        }else{
            return currentViewController;
        }
    }else{
        return nil;
    }
}
+ (UIWindow *)displayWindow{
    __block UIWindow *window = nil;
    [[UIApplication sharedApplication].windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIWindow class]]) {
            window = obj;
        }
    }];
    return window;
}

+ (UIViewController *)topOfRootViewController{
    return [self displayUIViewController:[self displayWindow].rootViewController ignorePresent:YES];
}

@end
