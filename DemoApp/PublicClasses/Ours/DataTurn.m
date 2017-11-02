//
//  PrintObject.m
//  weimob
//
//  Created by jing on 14-3-20.
//  Copyright (c) 2014年 hsmob. All rights reserved.
//

#import "DataTurn.h"
#import <objc/runtime.h>

@implementation BOBObject
@end

@implementation DataTurn

+ (NSDictionary*)getDicByObject:(id)obj
{
    BOBObject *objBOB = [[BOBObject alloc] init];
    objBOB.object = obj;
    
    NSDictionary *dic = [DataTurn getObjectData:objBOB];
    return dic;
}

+ (id)getObjByDic:(NSDictionary *)dic
{
    BOBObject *objBOB = [[BOBObject alloc] init];
    [DataTurn setObject:objBOB Data:dic];
    return objBOB.object;
}


+ (NSString *)getJsonStrByObj:(id)obj
{
    NSData *jsonData = [DataTurn getJSON:obj options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

+ (id)getObjByJsonStr:(NSString *)JsonStr
{
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:[JsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    return [DataTurn getObjByDic:jsonDic];
}

+ (NSDictionary*)getObjectData:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil)
        {
            value = [NSNull null];
        }
        else
        {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    return dic;
}

+ (void)print:(id)obj
{
    NSLog(@"%@", [self getDicByObject:obj]);
}


+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error
{
    return [NSJSONSerialization dataWithJSONObject:[self getDicByObject:obj] options:options error:error];
}

+ (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}

+ (id)setObject:(id)obj Data:(NSDictionary *)dic
{
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++) {
        objc_property_t prop = props[i];
        id value = nil;
        
        @try {
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
            value = [dic objectForKey:propName];
            if(value != nil) {
                [obj setValue:value forKey:propName];
            }
        }
        @catch (NSException *exception) {
        }
        
    }
    return obj;
}
// 将字典或者数组转化为JSON串
+(NSString *)toJSONData:(id)theData{
    
    if (theData == nil) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:0
                                                         error:&error];//NSJSONWritingPrettyPrinted的意思是将生成的json数据格式化输出，这样可读性高，不设置则输出的json字符串就是一整行。
//    NSString *data = [theData JSONRepresentation];
    NSString *data = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return data;
//    if ([jsonData length] > 0 && error == nil){
//        //使用这个方法的返回，我们就可以得到想要的JSON串
//        NSString *jsonString = [[NSString alloc] initWithData:jsonData
//                                                     encoding:NSUTF8StringEncoding];
//        return jsonString;
//    }else{
//        return nil;
//    }
}
// 将字典或者数组转化为JSON串 并不生存json数据格式 也就是不带换行和空格
+(NSString *)toJSONPrettyPrintedData:(id)theData{
    if (theData == nil) {
        return nil;
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:0
                                                         error:&error];//NSJSONWritingPrettyPrinted的意思是将生成的json数据格式化输出，这样可读性高，不设置则输出的json字符串就是一整行。
//    NSString *data = [theData JSONRepresentation];
    NSString *data = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return data;
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
//                                                       options:1000
//                                                       //options:NSJSONWritingPrettyPrinted
//                                                         error:&error];
//    
//    if ([jsonData length] > 0 && error == nil){
//        //使用这个方法的返回，我们就可以得到想要的JSON串
//        NSString *jsonString = [[NSString alloc] initWithData:jsonData
//                                                     encoding:NSUTF8StringEncoding];
//        return jsonString;
//    }else{
//        return nil;
//    }
}
//NSDictionary中的 NSArray 转对象 数组
+(NSMutableArray *)getObjArrByJsonStr:(NSArray *)dicArr ClassName:(NSString *)_className{
    NSMutableArray *loc_arr=[[NSMutableArray alloc]init];
    if(dicArr==nil||dicArr==NULL||[dicArr isEqual:@"null"]||[dicArr isEqual:[NSNull null]]||![dicArr isKindOfClass:[NSArray class]]){
        return loc_arr;
    }
    Class someClass = NSClassFromString(_className);
    for (int i=0; i<[dicArr count]; i++){
        NSDictionary *loc_dic=[dicArr objectAtIndex:i];
        id loc_data = [[someClass alloc] initWithDictionary:loc_dic];//Jastor中的转化函数
        [loc_arr addObject:loc_data];
    }
    return loc_arr;
}
//NSDictionary中的 转对象 单个
+(id)getObjByJsonStr:(NSDictionary *)dicData ClassName:(NSString *)_className{
    id loc_dicData=dicData;
    if([loc_dicData isKindOfClass:[NSArray class]]){
        NSLog(@"这是个数组");
        return nil;
    }
    
    if (![loc_dicData isKindOfClass:[NSDictionary class]]) {
        NSLog(@"这不是字典");
        return nil;
    }
    
    if(dicData==nil||dicData==NULL||[dicData isEqual:@"null"]||[dicData isEqual:[NSNull null]]||[[dicData description] isEqual:@"()"]){
        return nil;
    }
    Class someClass = NSClassFromString(_className);
    id loc_data = [[someClass alloc] initWithDictionary:dicData];//Jastor中的转化函数
    return loc_data;
}
//fxh
+(id)JSONDataWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [self JSONDataWithData:jsonData];
}

+(id)JSONDataWithData:(NSData *)jsonData {
    
    if (jsonData == nil) {
        return nil;
    }
    NSError *err;
    id transValue = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return transValue;
}

@end
