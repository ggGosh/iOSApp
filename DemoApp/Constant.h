//
//  Constant.h
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/1.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

//设计用的分辨率
#define DesignScreenHeight  667
#define DesignScreenWidth   375
//基本信息获取
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] doubleValue]>=9.0)
#define IOS11 @available(iOS 11.0, *)
//判断是iPhoneX 的宏
#define is_iPhoneX [UIScreen mainScreen].bounds.size.width == 375.0f && [UIScreen mainScreen].bounds.size.height == 812.0f

#define DeviceId [UIDevice currentDevice].identifierForVendor.UUIDString

#define GV_DocumentFolder                    [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define GV_LibraryFolder                    [NSHomeDirectory() stringByAppendingPathComponent:@"Library"]
#define GV_TmpFolder                    NSTemporaryDirectory()
#define GV_CachesFolder  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]

//常用宏
//NSString 类型 并不为空
#define IsStrNotEmpty(_ref) ([_ref isKindOfClass:[NSString class]] && ![_ref isEqualToString:@""])

// weakself 宏
#define WEAKSELF    __weak __typeof(&*self) weakSelf = self;

//text size
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define VD_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define VD_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif



#endif /* Constant_h */
