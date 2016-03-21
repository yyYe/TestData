//
//  MeLableItem.m
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "MeLableItem.h"

@implementation MeLableItem

+ (instancetype)itemWithTitle:(NSString *)title details:(NSString *)details  targrtClass:(Class)targetClass{
    return [self itemWithIcon:nil title:title details:details targrtClass:targetClass];
}

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title details:(NSString *)details targrtClass:(Class)targetClass{
    MeLableItem *item = [MeLableItem itemWithIcon:icon title:title targrtClass:targetClass];
    item.details = details;
    return item;
}

@end
