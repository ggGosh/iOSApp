//
//  CheckLoginTool.m
//  WeiKe
//
//  Created by js on 16/8/18.
//  Copyright © 2016年 WeiMob. All rights reserved.
//

#import "CheckLoginTool.h"
#import "ViewController.h"

@implementation CheckLoginTool


- (BOOL)checkLogin:(id)target sel:(SEL)sel animated:(BOOL)animated{
    
    NSMethodSignature *sig = [[target class] instanceMethodSignatureForSelector:sel];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    invocation.target = target;
    invocation.selector = sel;
    
    if ([[MySingleton sharedSingleton] loginedIn]) {
        [invocation invoke];
        return YES;
    } else {
        [[self rootViewController] showLogin:invocation animated:animated];
    }
    
    return NO;
}

- (ViewController *)rootViewController{
    ViewController *viewC = [ViewController getMainViewController];
    return viewC;
}

@end
