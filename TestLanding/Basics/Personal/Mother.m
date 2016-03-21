//
//  Mother.m
//  YiMaMa
//
//  Created by LWF on 16/1/25.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import "Mother.h"

@implementation Mother

- (instancetype)init{
    if (self = [super init]) {
        self.babies = [@[] copy];
    }
    return self;
}

+ (instancetype)motherWithDict:(NSDictionary *)dict{
    Mother *mother = [self personWithDict:dict];
    mother.intro = nonNullString(dict[@"intro"]);
    return mother;
}

+ (NSArray *)motherWithArray:(NSArray *)mothers{
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (NSDictionary *dict in mothers) {
        Mother *mother = [Mother motherWithDict:dict];
        [tempArr addObject:mother];
    }
    return [tempArr copy];
}

@end
