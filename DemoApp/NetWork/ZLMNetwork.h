//
//  ZLMNetwork.h
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/1.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLMResponseHandler.h"
#import "ZLMSession.h"

@interface ZLMNetwork : NSObject

/** 成功的回调 */
typedef void (^ZLMNetworkSuccessBlock)(id _Nullable response,
                                      ZLMResponseHandler *handler);
/** 失败的回调 */
typedef void (^ZLMNetworkFailureBlock) (NSError *error,
                                        ZLMResponseHandler *handler);
/** 成功或失败都调用的回调 */
typedef void (^ZLMNetworkCallBackBlock) (void);

/** 进度 */
typedef void(^ZLMNetworkProgressBlock) (NSProgress * _Nonnull progress,
                                        int64_t completedUnitCount,
                                        int64_t totalUnitCount,
                                        CGFloat percentage);

/**
 GET请求方式
 
 @param path 接口
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 @param callBack 成功或失败都调用
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)getWithPath:(NSString *)path
                           parameters:(NSDictionary * _Nullable)parameters
                              success:(ZLMNetworkSuccessBlock)success
                              failure:(ZLMNetworkFailureBlock)failure
                             callBack:(ZLMNetworkCallBackBlock)callBack;

/**
 POST请求方式
 
 @param path 接口
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 @param callBack 成功或失败都调用
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)postWithPath:(NSString *)path
                            parameters:(NSDictionary * _Nullable)parameters
                               success:(ZLMNetworkSuccessBlock)success
                               failure:(ZLMNetworkFailureBlock)failure
                              callBack:(ZLMNetworkCallBackBlock)callBack;

/**
 上传多张图片
 
 @param path 接口
 @param parameters 参数
 @param imageArray 要上传的所有图片
 @param name 后台要根据这个key来取图片
 @param progress 进度
 @param success 成功回调
 @param failure 失败回调
 @param callBack 成功或失败都调用
 @return NSURLSessionDataTask
 */

+ (NSURLSessionDataTask *)uploadImageWithPath:(NSString *)path
                                   parameters:(NSDictionary * _Nullable)parameters
                                   imageArray:(NSArray<UIImage *> *)imageArray
                                         name:(NSString * _Nullable)name
                                     progress:(ZLMNetworkProgressBlock)progress
                                      success:(ZLMNetworkSuccessBlock)success
                                      failure:(ZLMNetworkFailureBlock)failure
                                     callBack:(ZLMNetworkCallBackBlock)callBack;

@end
