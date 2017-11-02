//
//  CheckLoginTool.h
//  WeiKe
//
//  Created by js on 16/8/18.
//  Copyright © 2016年 WeiMob. All rights reserved.
//

#import <Foundation/Foundation.h>

static char checkImKey;
@interface CheckLoginTool : NSObject
- (BOOL)checkLogin:(id)target sel:(SEL)sel animated:(BOOL)animated;

@end
