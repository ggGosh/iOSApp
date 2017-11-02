//
//  ZLMSession.m
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/1.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import "ZLMSession.h"

@implementation ZLMSession

+ (instancetype)shared{
    static ZLMSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[ZLMSession alloc] initWithBaseURL:[NSURL URLWithString:@"www.baidu.com"]];
        NSDictionary<NSString *,NSString *> *headers = @{
                                                         @"AppVersion": @"", // APP版本号
                                                         @"Channel": @"Channel_Default", // 渠道类型
                                                         @"mt": @"ios",
                                                         @"mk": @"", // 设备唯一编号
                                                         @"User-Agent":@""
                   
                                                       };
        [headers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            [session.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
        // 接收的数据类型
        NSArray *contTypes = @[
                               @"application/json",
                               @"text/json",
                               @"text/plain",
                               @"text/javascript",
                               @"text/html",
                               ];
        session.responseSerializer.acceptableContentTypes = [NSSet setWithArray:contTypes];
    });
    return session;
}

#pragma mark 设置请求头
/**
 *  设置请求头
 *
 *  @param value       value
 *  @param headerField headerField
 */
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)headerField {
    [[ZLMSession shared].requestSerializer setValue:value forHTTPHeaderField:headerField];
}
@end
