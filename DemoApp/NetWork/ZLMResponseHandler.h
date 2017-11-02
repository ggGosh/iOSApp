//
//  ZLMResponseHandler.h
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/1.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLMResponseHandler : NSObject

/** 未处理前的数据对象 */
@property (nonatomic, copy) id response;

/** 状态码 */
@property (nonatomic, assign) NSInteger code;
/** 成功或错误消息 */
@property (nonatomic, copy) NSString *msg;

/** 是否请求成功 */
@property (nonatomic, assign) BOOL isSuccess;
/** 数据是否为空 */
@property (nonatomic, assign) BOOL isNilData;

/** 错误相关信息 */
@property (nonatomic, strong) NSError *error;


/**
 通过此方法处理请求的数据
 
 @param response 请求的数据
 @param path 接口
 @return TSYResponseHandler
 */
+ (ZLMResponseHandler *)handleResponse:(id)response
                                  path:(NSString *)path;

/**
 如果请求失败则通过此方法处理
 
 @param error NSError
 @param msg 错误消息
 @param path 接口
 @paeam response response
 */
+ (void)handleError:(NSError *)error
                msg:(NSString *)msg
               path:(NSString *)path
           response:(id)response;
@end
