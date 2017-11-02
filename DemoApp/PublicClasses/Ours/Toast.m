//
//  Toast.m
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/2.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import "Toast.h"
#import "MBProgressHUD.h"

@implementation Toast

+ (void)toastNetWorkMessage:(NSString *)message {
    [self toastMessage:message inView:nil yOffset:150.f showTime:0];
}

+ (void)toastDebugMessage:(NSString *)message {
    
#if defined(DEBUG)||defined(_DEBUG)
    [self toastMessage:message inView:nil yOffset:150.f showTime:0];
#endif
    
}

+ (void)toastMessage:(NSString *)message inView:(UIView *)view yOffset:(CGFloat)yOffset {
    [self toastMessage:message inView:view yOffset:yOffset showTime:0];
}

+ (void)toastMessage:(NSString *)message {
    [self toastMessage:message inView:nil yOffset:150.f showTime:0];
}

+ (void)toastMessage:(NSString *)message inView:(UIView *)view yOffset:(CGFloat)yOffset showTime:(CGFloat)showTime{
    
    [self hiddenToastForView:view animated:NO];
    
    if (![message isKindOfClass:[NSString class]]) {
        return;
    }
    
    if (message.length == 0) {
        return;
    }
    
    if(view == nil){
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        view = window;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.detailsLabelText = message;
    hud.margin = 10.f;
    hud.yOffset = yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:showTime > 0 ? showTime:3];
}

+ (void)hiddenToastForView:(UIView *)view animated:(BOOL)animated {
    if(view == nil){
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        view = window;
    }
    [MBProgressHUD hideHUDForView:view animated:animated];
}

@end
