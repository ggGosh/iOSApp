//
//  NSArray+Safe.m
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/3.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //NSArray
        Method method = class_getInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndex:));
        Method method2 = class_getInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(safeObjectAtIndex:));
        method_exchangeImplementations(method, method2);
        
        
        Class array0Cls = NSClassFromString(@"__NSArray0");
        if (array0Cls){
            Method method = class_getInstanceMethod(array0Cls, @selector(objectAtIndex:));
            Method method2 = class_getInstanceMethod(array0Cls, @selector(safeObjectAtIndex2:));
            method_exchangeImplementations(method, method2);
        }
    });
}

- (id )safeObjectAtIndex:(NSInteger)index{
    if (self.count > index) {
        return [self safeObjectAtIndex:index];
    }
    
    NSLog(@"数组越界");
    return nil;
}

- (id )safeObjectAtIndex2:(NSInteger)index{
    if (self.count > index) {
        return [self safeObjectAtIndex2:index];
    }
    
    NSLog(@"数组越界");
    return nil;
}

- (id )objectForKey:(NSString *)index{
    return nil;
}

@end
