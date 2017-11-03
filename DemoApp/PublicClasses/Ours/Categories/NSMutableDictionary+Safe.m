//
//  NSMutableDictionary+Safe.m
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/3.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"

@implementation NSMutableDictionary (Safe)

+ (void)load{
    static dispatch_once_t oneceToken;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method method = class_getInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKey:));
        Method method2 = class_getInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(safeSetObject:forKey:));
        method_exchangeImplementations(method, method2);
    });
}

- (void)safeSetObject:(id)object forKey:(id)key{
    if (object && key){
        [self safeSetObject:object forKey:key];
    }
    else{
        NSLog(@"字典赋值存在空 key: %@, val: %@",key,object);
    }
}

@end
