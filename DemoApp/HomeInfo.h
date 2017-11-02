//
//  HomeInfo.h
//  DemoApp
//
//  Created by 谭学勇 on 2017/11/2.
//  Copyright © 2017年 谭学勇. All rights reserved.
//

#import "Jastor.h"

@interface PictureInfo : Jastor

@property (nonatomic, copy) NSString *title;

@end

@interface HomeInfo : Jastor

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) PictureInfo *pic;
@property (nonatomic, strong) NSArray <PictureInfo *>*pics;

@end

