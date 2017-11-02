//
//  ZLMNetworkStatus.m
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/1.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import "ZLMNetworkStatus.h"

@implementation ZLMNetworkStatus

+ (instancetype)shared {
    static ZLMNetworkStatus *s = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s = [ZLMNetworkStatus new];
    });
    return s;
}

+ (void)startMonitoring {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"网络状态：%zd", status);
        [[ZLMNetworkStatus shared] setValue:@(status) forKey:@"_status"];
    }];
    
    // 要监测网络连接状态，必须要先调用单例的startMonitoring方法开启
    [manager startMonitoring];
}


@end
