//
//  ZLMNetworkStatus.h
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/1.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworkReachabilityManager.h>

@interface ZLMNetworkStatus : NSObject

/** 网络状态 */
@property (nonatomic, readonly, assign) AFNetworkReachabilityStatus status;

/**
 单例
 
 @return instancetype
 */
+ (instancetype)shared;

/**
 调用此方法开始监测网络状态
 */
+ (void)startMonitoring;

@end
