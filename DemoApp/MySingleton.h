//
//  MySingle.h
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/1.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySingleton : NSObject

+ (MySingleton *)sharedSingleton;
- (BOOL)loginedIn;

@end
