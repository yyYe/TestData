//
//  Mother.h
//  YiMaMa
//
//  Created by LWF on 16/1/25.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonBase.h"
#import "Baby.h"

@interface Mother : PersonBase

@property (nonatomic, copy) NSString *intro; //介绍

/**    要单独解析赋值，里面是Baby对象     */
@property (nonatomic, strong) NSArray *babies;

+ (instancetype)motherWithDict:(NSDictionary *)dict;
+ (NSArray *)motherWithArray:(NSArray *)mothers;

@end
