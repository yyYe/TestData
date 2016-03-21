//
//  FGImageItem.m
//  YiMaMa
//
//  Created by LWF on 16/1/24.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import "ImageItem.h"

@implementation ImageItem

+ (instancetype)itemWithDict:(NSDictionary *)dict{
    ImageItem *item = [[self alloc]init];
    item.originalUrl = dict[@"filePath"];
    
    return item;
}

@end
