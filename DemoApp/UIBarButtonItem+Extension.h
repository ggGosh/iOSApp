//
//  UIBarButtonItem+Extension.h
//  DemoApp
//
//  Created by 谭学勇 on 2017/10/27.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTargat:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;


@end
