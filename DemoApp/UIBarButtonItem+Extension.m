//
//  UIBarButtonItem+Extension.m
//  DemoApp
//
//  Created by 谭学勇 on 2017/10/27.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)

/**
 创建一个item

 @param target 点击item后调用哪个对象的方法
 @param action 点击item后调用target的哪个方法
 @param image 图片
 @param highImage 高亮的图片
 @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTargat:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}



@end
