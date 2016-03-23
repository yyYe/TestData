//
//  Baby.m
//  YiMaMa
//
//  Created by LWF on 16/1/25.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import "Baby.h"

@implementation Baby

+ (instancetype)babyWithDict:(NSDictionary *)dict{
    Baby *baby = [[self alloc]init];
    baby.gender = [dict[@"gender"] intValue];
    baby.userId = nonNullString(dict[@"id"]);
    baby.age = nonNullString(dict[@"age"]);
//    baby.name = dict[@"babyName"]; baby只用nickName
    baby.nickName = nonNullString(dict[@"babyName"]);
    baby.birthday = nonNullString(dict[@"birthday"]);
    baby.avatarString = nonNullString(dict[@"headerImg"]);
    baby.intro = nonNullString(dict[@"intro"]);
    baby.xuid = nonNullString(dict[@"xuid"]);
    baby.ageDesc = nonNullString(dict[@"babyAgeDesc"]);
    return baby;
}

+ (NSArray *)babyWithArray:(NSArray *)babies{
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (NSDictionary *dict in babies) {
        Baby *baby = [Baby babyWithDict:dict];
        [tempArr addObject:baby];
    }
    return [tempArr copy];
}

@end
