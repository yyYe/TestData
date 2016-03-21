//
//  PersonBase.m
//  YiMaMa
//
//  Created by LWF on 16/1/26.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import "PersonBase.h"

@implementation PersonBase

+ (instancetype)personWithDict:(NSDictionary *)dict{
    PersonBase *person = [[self alloc]init];
    person.userId = nonNullString(dict[@"id"]);
//    person.avatar.originalUrl = nonNullString(dict[@"headerImg"]);
    person.phoneNumber = nonNullString(dict[@"phone"]);
    person.levelName = nonNullString(dict[@"rankTitle"]);
    person.address = nonNullString(dict[@"area"]);
    person.birthday = nonNullString(dict[@"birthday"]);
    person.nickName = nonNullString(dict[@"userNick"]);
    person.xuid = nonNullString(dict[@"xuid"]);
    person.signature = nonNullString(dict[@"userSig"]);
    person.level = nonNullString(dict[@"userRank"]);
//    person.gender = [nonNullString(dict[@"gender"]) intValue];
    
    return person;
}

@end
