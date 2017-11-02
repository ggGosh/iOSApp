//
//  MySingle.m
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/1.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import "MySingleton.h"

@implementation MySingleton

+ (MySingleton *)sharedSingleton
{
    static MySingleton *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[MySingleton alloc] init];
        return sharedSingleton;
    }
}

- (BOOL)loginedIn{
    return NO;
}

@end
