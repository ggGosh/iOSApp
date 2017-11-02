//
//  Toast.h
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/2.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Toast : NSObject

+ (void)toastMessage:(NSString *)message inView:(UIView *)view yOffset:(CGFloat)yOffset;
+ (void)toastMessage:(NSString *)message inView:(UIView *)view yOffset:(CGFloat)yOffset showTime:(CGFloat)showTime;

+ (void)toastMessage:(NSString *)message;

//网络问题专用 toast
+ (void)toastNetWorkMessage:(NSString *)message;

//debug 下显示 toast
+ (void)toastDebugMessage:(NSString *)message;

//隐藏 toast
+ (void)hiddenToastForView:(UIView *)view animated:(BOOL)animated;

@end
