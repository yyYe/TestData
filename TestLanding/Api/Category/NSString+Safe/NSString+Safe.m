//
//  NSString+Safe.m
//  YiMaMa
//
//  Created by LWF on 16/1/27.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import "NSString+Safe.h"

NSString * nonNullString(id str){
    if (![str isKindOfClass:[NSString class]]) {
        str = [NSString stringWithFormat:@"%@",str];
    }
    
    // NSNull变为 @"<null>"
    return [str isEqualToString:@"<null>"] ? nil : str;
}