//
//  ZLMResponseHandler.m
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/1.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import "ZLMResponseHandler.h"

@implementation ZLMResponseHandler

- (instancetype)init {
    self = [super init];
    if (self) {
        _code = 0; // 初始状态码为未知
        _isNilData = YES; // 初始数据为空
    }
    return self;
}

+ (ZLMResponseHandler *)handleResponse:(id)response path:(NSString *)path{
    ZLMResponseHandler *handler = [ZLMResponseHandler new];
    handler.response = response;
    // 提取状态码
    if (response[@"errorCode"] &&
        ![response[@"errorCode"] isKindOfClass:[NSNull class]]) {
        handler.code = [response[@"errorCode"] integerValue];
    }
    // 判断状态码
    if (0 == handler.code) {
        handler.isSuccess = YES;
    }else{
        handler.isSuccess = NO;
    }
    // 提取数据判断是否有数据
    if (response[@"Data"] &&
        ![response[@"Data"] isKindOfClass:[NSNull class]]) {
        NSDictionary *data = response[@"Data"];
        if ([data isKindOfClass:[NSDictionary class]]) {
            // 字典里有数据
            if (((NSDictionary *)data).count) {
                handler.isNilData = NO;
            }
        } else if ([data isKindOfClass:[NSArray class]]) {
            // 数组里有数据
            if (((NSArray *)data).count) {
                handler.isNilData = NO;
            }
        }
    }
    // 提取消息
    if (response[@"Message"] &&
        ![response[@"Message"] isKindOfClass:[NSNull class]]) {
        handler.msg = response[@"Message"];
    }else {
        handler.msg = @"";
    }
    // 如果错误了，处理下错误
    if (!handler.isSuccess) {
        [ZLMResponseHandler handleError:handler.error msg:handler.msg path:path response:handler.response];
    }
    
    /* 在这里统一打印下数据 */
    NSLog(@"\n接口: %@\n", path);
    NSLog(@"\nisSuccess: %zi  isNilData: %zi  msg: %@\n", handler.isSuccess, handler.isNilData, handler.msg);
    NSString *data;
    if (response) {
        data = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:response options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    }
    NSLog(@"\n请求到的数据: \n%@\n", data);
    
    return handler;
}

+ (void)handleError:(NSError *)error msg:(NSString *)msg path:(NSString *)path response:(id)response {
    
    NSLog(@"\n处理错误（response）:\n%@", response);
    
}


@end
