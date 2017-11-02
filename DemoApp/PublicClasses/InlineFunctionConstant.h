//
//  InlineFunctionConstant.h
//  WeiKe
//
//  Created by WuShiHai on 6/24/15.
//  Copyright (c) 2015 jing. All rights reserved.
//

#ifndef WeiKe_InlineFunctionConstant_h
#define WeiKe_InlineFunctionConstant_h

#import <objc/runtime.h>

typedef struct {
    CGFloat StatusBarHeight;
    CGFloat NavigationBarHeight;
    CGFloat TabbarHeight;
}iPhone_Info;

static inline NSString * VDFontAttributeName(){
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    return NSFontAttributeName;
#else
    return UITextAttributeFont;
#endif
}
static inline NSString * VDForegroundColorAttributeName(){
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    return NSForegroundColorAttributeName;
#else
    return UITextAttributeTextColor;
#endif
}
static inline NSString * VDShadowColorAttributeName(){
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    return NSShadowAttributeName;
#else
    return UITextAttributeTextShadowColor;
#endif
}
static inline NSString * VDShadowOffsetAttributeName(){
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    return NSShadowAttributeName;
#else
    return UITextAttributeTextShadowOffset;
#endif
    
}

static inline iPhone_Info iPhoneInfo(){
    iPhone_Info info;
    if (is_iPhoneX) {
        info.StatusBarHeight = 44;
        info.NavigationBarHeight = 88;
        info.TabbarHeight = 83;
    }else{
        info.StatusBarHeight = 20;
        info.NavigationBarHeight = 64;
        info.TabbarHeight = 49;
    }
    return info;
}

static inline CGFloat VDScaleHeight(CGFloat designedHeight){
    return designedHeight * ScreenHeight / DesignScreenHeight;
}
static inline CGFloat VDScaleWidth(CGFloat designedWidth){
    return designedWidth * ScreenWidth / DesignScreenWidth;
}

///缓存文件地址， 存储到沙盒的Cache 文件夹中
static inline NSString* cachePathForFileName(NSString * fileName){
    NSArray* myPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* myCachePath = [myPaths objectAtIndex:0];
    NSString* fileFullPath = [myCachePath stringByAppendingPathComponent:fileName];
    return fileFullPath;
}

static inline UIButton * commitButtonFactory(CGRect frame,NSString *title,NSString *imageName,UIColor *titleColor,UIColor *backgroundColor,UIFont *titleFont,CGFloat cornerRadius,id target,SEL selector){
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundColor:backgroundColor];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    if (cornerRadius > 0) {
        button.layer.cornerRadius = cornerRadius;
        button.layer.masksToBounds = YES;
    }
    if (titleFont) {
        [button.titleLabel setFont:titleFont];
    }
    
    return button;
}

static IMP WMMIReplaceMethodWithBlock(Class c, SEL origSEL, id block) {
    NSCParameterAssert(block);
    
    // get original method
    Method origMethod = class_getInstanceMethod(c, origSEL);
    NSCParameterAssert(origMethod);
    
    // convert block to IMP trampoline and replace method implementation
    IMP newIMP = imp_implementationWithBlock(block);
    
    // Try adding the method if not yet in the current class
    if (!class_addMethod(c, origSEL, newIMP, method_getTypeEncoding(origMethod))) {
        return method_setImplementation(origMethod, newIMP);
    }else {
        return method_getImplementation(origMethod);
    }
}

#endif
