//
//  FGMeBaseItem.m
//  YiMaMa
//
//  Created by LWF on 16/1/15.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import "PersonalCenter.h"

@implementation PersonalCenter


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title targrtClass:(Class)targetClass{
    PersonalCenter *item = [[self alloc]init];
    item.icon = icon;
    item.title = title;
    item.targetClass = targetClass;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title targrtClass:(Class)targetClass{
    return [self itemWithIcon:nil title:title targrtClass:targetClass];
}

+ (instancetype)itemWithTitle:(NSString *)title avatar:(NSString *)avatar targrtClass:(Class)targetClass {
    PersonalCenter *item = [[self alloc]init];
    item.avatar = avatar;
    item.title = title;
    item.targetClass = targetClass;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder {
    PersonalCenter *item = [[self alloc]init];
    item.title = title;
    item.placeholder = placeholder;
    return item;
}

@end
