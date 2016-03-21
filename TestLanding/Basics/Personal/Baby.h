//
//  Baby.h
//  YiMaMa
//
//  Created by LWF on 16/1/25.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonBase.h"

@interface Baby : PersonBase
/**   详细年龄 如:11岁4天   */
@property (nonatomic, copy) NSString *ageDesc;
@property (nonatomic, copy) NSString *intro;

+ (instancetype)babyWithDict:(NSDictionary *)dict;
+ (NSArray *)babyWithArray:(NSArray *)babies;

@end
