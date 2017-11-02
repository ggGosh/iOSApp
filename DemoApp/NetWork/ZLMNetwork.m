//
//  ZLMNetwork.m
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/1.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import "ZLMNetwork.h"

@implementation ZLMNetwork

#pragma mark 开始请求时要调用这个方法
+ (void)beginRequestWithPath:(NSString *)path
                  parameters:(NSDictionary *)parameters
                      method:(NSString *)method {
    
#ifdef DEBUG
    
    path = [path hasPrefix:@"http"] ? path : [NSString stringWithFormat:@"%@%@", [ZLMSession shared].baseURL, path];
    
    NSMutableString *pathAndParams = [[NSMutableString alloc] initWithString:path];
    [pathAndParams appendString:@"?"];
    
    for (NSString *categoryId in [parameters allKeys]) {
        [pathAndParams appendFormat:@"%@=%@&",categoryId, [parameters objectForKey:categoryId]];
    }

    NSLog(@"\n                                       \
          \n*************** 网络请求开始 ***************\
          \n                                          \
          \n请求方法：%@                                \
          \n接口：%@                                   \
          \n", method, [pathAndParams substringToIndex:[pathAndParams length] - 1]);
    //    NSLog(@"\n请求方法: %@", method);
    //    NSLog(@"\n接口: %@", [pathAndParams substringToIndex:[pathAndParams length] - 1]);
    //    NSLog(@"\n原始参数: \n%@", parameters);
    
#endif
}

#pragma mark 结束请求时要调用这个方法
+ (void)endRequest {
    
    NSLog(@"\n                                       \
          \n*************** 网络请求结束 ***************\
          \n                                          ");
}

+ (NSDictionary *)addCommonParameters:(NSDictionary *)parameters {
    
    // 添加公共参数
    NSString *version = @"";
    NSString *versionCode = [version stringByReplacingOccurrencesOfString:@"." withString:@""];
  
    NSMutableDictionary *dict = nil;
    if (parameters) {
        dict = (parameters).mutableCopy;
    } else {
        dict = [NSMutableDictionary new];
    }
    
    dict[@"versionCode"] = versionCode;
    
    NSLog(@"\n增加公共参数后的参数:\n%@", dict);
    
    return dict;
}

#pragma mark - Data handle
#pragma mark Success
+ (void)networkSuccessWithPath:(NSString *)path
                    parameters:(NSDictionary *)parameters
                       success:(ZLMNetworkSuccessBlock)success
                       failure:(ZLMNetworkFailureBlock)failure
                      callBack:(ZLMNetworkCallBackBlock)callBack
                          task:(NSURLSessionDataTask * _Nonnull)task
                      response:(id _Nullable)response {
    
    ZLMResponseHandler *handler = [ZLMResponseHandler handleResponse:response path:path];
    if (handler.isSuccess) {
        if (success) success(handler.response, handler);
    } else {
        if (failure) failure(handler.error, handler);
    }
    
    if (callBack) {
        callBack();
    }
    
    [self endRequest];
}
#pragma mark Failure
+ (void)networkFailureWithPath:(NSString *)path
                    parameters:(NSDictionary *)parameters
                       success:(ZLMNetworkSuccessBlock)success
                       failure:(ZLMNetworkFailureBlock)failure
                      callBack:(ZLMNetworkCallBackBlock)callBack
                          task:(NSURLSessionDataTask * _Nonnull)task
                         error:(NSError * _Nonnull)error {
    
    /* 在这里判断下数据是为了解决服务器500，但是数据正常问题 */
    BOOL didHandle = NO;
    if (error.userInfo || [error.userInfo isKindOfClass:[NSDictionary class]]) {
        
        if (error.userInfo[@"NSLocalizedDescription"] &&
            [error.userInfo[@"NSLocalizedDescription"] isKindOfClass:[NSString class]] &&
            [error.userInfo[@"NSLocalizedDescription"] hasSuffix:@"internal server error (500)"]) {
            
            if (error.userInfo[@"com.alamofire.serialization.response.error.data"] &&
                ![error.userInfo[@"com.alamofire.serialization.response.error.data"] isKindOfClass:[NSNull class]]) {
                //注释
                //                TSYDMRoot *dmRoot = [TSYDMRoot yy_modelWithJSON:error.userInfo[@"com.alamofire.serialization.response.error.data"]];
                //                if (dmRoot.data && ![dmRoot.data isKindOfClass:[NSNull class]] &&
                //                    dmRoot.msg && ![dmRoot.msg isKindOfClass:[NSNull class]]) {
                //
                //                    [TSYNetwork networkSuccessWithPath:path
                //                                            parameters:parameters
                //                                               success:success
                //                                               failure:failure
                //                                              callBack:callBack
                //                                                  task:task
                //                                              response:[dmRoot yy_modelToJSONObject]];
                //
                                    didHandle = YES;
                //                }
            }
        }
    }
    
    if (!didHandle) {
        [ZLMResponseHandler handleError:error msg:nil path:path response:nil];
        if (failure) {
            failure(error, [ZLMResponseHandler new]);
        }
        
        if (callBack) {
            callBack();
        }
        
        [self endRequest];
    }
}

+ (NSURLSessionDataTask *)getWithPath:(NSString *)path
                           parameters:(NSDictionary *)parameters
                              success:(ZLMNetworkSuccessBlock)success
                              failure:(ZLMNetworkFailureBlock)failure
                             callBack:(ZLMNetworkCallBackBlock)callBack {
    
    NSDictionary *parms = [ZLMNetwork addCommonParameters:parameters];
    
    [ZLMNetwork beginRequestWithPath:path parameters:parameters method:@"GET"];
    
    ZLMSession *session = [ZLMSession shared];
    return [session GET:path
             parameters:parms
               progress:^(NSProgress * _Nonnull downloadProgress) {
                   
               } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   
                   [ZLMNetwork networkSuccessWithPath:path
                                           parameters:parameters
                                              success:success
                                              failure:failure
                                             callBack:callBack
                                                 task:task
                                             response:responseObject];
                   
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   
                   [ZLMNetwork networkFailureWithPath:path
                                           parameters:parameters
                                              success:success
                                              failure:failure
                                             callBack:callBack
                                                 task:task
                                                error:error];
               }];
}

#pragma mark POST
+ (NSURLSessionDataTask *)postWithPath:(NSString *)path
                            parameters:(NSDictionary *)parameters
                               success:(ZLMNetworkSuccessBlock)success
                               failure:(ZLMNetworkFailureBlock)failure
                              callBack:(ZLMNetworkCallBackBlock)callBack {
    
    NSDictionary *parms = [ZLMNetwork addCommonParameters:parameters];
    
    [ZLMNetwork beginRequestWithPath:path parameters:parameters method:@"POST"];
    
    ZLMSession *session = [ZLMSession shared];
    return [session POST:path
              parameters:parms
                progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    [ZLMNetwork networkSuccessWithPath:path
                                            parameters:parameters
                                               success:success
                                               failure:failure
                                              callBack:callBack
                                                  task:task
                                              response:responseObject];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    [ZLMNetwork networkFailureWithPath:path
                                            parameters:parameters
                                               success:success
                                               failure:failure
                                              callBack:callBack
                                                  task:task
                                                 error:error];
                }];
}

#pragma mark Upload images
+ (NSURLSessionDataTask *)uploadImageWithPath:(NSString *)path
                                   parameters:(NSDictionary * _Nullable)parameters
                                   imageArray:(NSArray<UIImage *> *)imageArray
                                         name:(NSString * _Nullable)name
                                     progress:(ZLMNetworkProgressBlock)progress
                                      success:(ZLMNetworkSuccessBlock)success
                                      failure:(ZLMNetworkFailureBlock)failure
                                     callBack:(ZLMNetworkCallBackBlock)callBack {
    
    NSDictionary *parms = [ZLMNetwork addCommonParameters:parameters];
    
    [ZLMNetwork beginRequestWithPath:path parameters:parameters method:@"POST"];
    
    ZLMSession *session = [ZLMSession shared];
    return [session POST:path parameters:parms constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [imageArray enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
            NSString *dateStr = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@%zi.jpg", dateStr, idx + 1];
            
            // 将image转换为data，这里压缩率为1
            NSData *imageData = UIImageJPEGRepresentation(obj, 1.0);
            
            // 拼接上图片，以文件流的格式
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            NSString *percentageStr = [NSString stringWithFormat:@"%.2lld", uploadProgress.completedUnitCount / uploadProgress.totalUnitCount];
            progress(uploadProgress, uploadProgress.completedUnitCount, uploadProgress.totalUnitCount, [percentageStr floatValue]);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [ZLMNetwork networkSuccessWithPath:path
                                parameters:parameters
                                   success:success
                                   failure:failure
                                  callBack:callBack
                                      task:task
                                  response:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ZLMNetwork networkFailureWithPath:path
                                parameters:parameters
                                   success:success
                                   failure:failure
                                  callBack:callBack
                                      task:task
                                     error:error];
        
    }];
}

@end
