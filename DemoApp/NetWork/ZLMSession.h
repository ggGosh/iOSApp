//
//  ZLMSession.h
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/1.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface ZLMSession : AFHTTPSessionManager

NS_ASSUME_NONNULL_BEGIN

/**
 单例

 @return instancetype
 */
+ (instancetype)shared;

/**
 *  设置请求头
 *
 *  @param value       value
 *  @param headerField headerField
 */
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)headerField;

NS_ASSUME_NONNULL_END

@end
