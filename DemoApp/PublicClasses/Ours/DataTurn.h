//
//  PrintObject.h
//  weimob
//
//  Created by jing on 14-3-20.
//  Copyright (c) 2014年 hsmob. All rights reserved.
/*
 数据转化 对象转化为string string转Object
 用法：
 1.json string转对象
 NSDictionary *data=[_data objectForKey:@"data"];
 NSMutableArray *loc_FromUsersArr=[DataTurn getObjArrByJsonStr:[data objectForKey:@"LockCustomers"] ClassName:@"FromUsers"];
 FromUsers 对象类名
 返回数组，数组里面存放的是FromUsers对象
 2.对象转json
 [DataTurn toJSONData:FromUsers];
 3.对象转字典  getDicByObject方法
 4.字典转对象  getObjByDic方法

 
 注：里面的对象必须继承Jastor类
 
 Created by jing on 2014年03月20日  版本1.0
 
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 添加接口
 5.NSDictionary转单个对象
 [DataTurn getObjArrByJsonStr:[data objectForKey:@"LockCustomers"] ClassName:@"FromUsers"];
 
 6// 将字典或者数组转化为JSON串 并不生存json数据格式 也就是不带换行和空格
 +(NSString *)toJSONPrettyPrintedData:(id)theData
 
 Created by jing on 2014年05月15日  版本1.1
 */
#import <Foundation/Foundation.h>


@interface BOBObject : NSObject
@property (strong, nonatomic) NSObject *object;
@end

@interface DataTurn : NSObject

+ (NSDictionary*)getDicByObject:(id)obj;
+ (id)getObjByDic:(NSDictionary *)dic;

+ (NSString *)getJsonStrByObj:(id)obj;
+ (id)getObjByJsonStr:(NSString *)JsonStr;


+ (NSDictionary*)getObjectData:(id)obj;
+ (void)print:(id)obj;
+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error;
+ (id)getObjectInternal:(id)obj;
+ (id)setObject:(id)obj Data:(NSDictionary *)dic;
// 将字典或者数组转化为JSON串
+(NSString *)toJSONData:(id)theData;
// 将字典或者数组转化为JSON串 并不生存json数据格式 也就是不带换行和空格
+(NSString *)toJSONPrettyPrintedData:(id)theData;
//json ->字典||数组
+(id)JSONDataWithJsonString:(NSString *)jsonString;
+(id)JSONDataWithData:(NSData *)jsonData;
//NSDictionary中的 NSArray 转对象 数组
+(NSMutableArray *)getObjArrByJsonStr:(NSArray *)dicArr ClassName:(NSString *)_className;
//NSDictionary中的 转对象 单个
+(id)getObjByJsonStr:(NSDictionary *)dicData ClassName:(NSString *)_className;
@end
