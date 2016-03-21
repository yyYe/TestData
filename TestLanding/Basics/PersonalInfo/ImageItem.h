//
//  FGImageItem.h
//  YiMaMa
//
//  Created by LWF on 16/1/24.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageItem : NSObject

/* 原图地址 */
@property (nonatomic, copy) NSString *originalUrl;

/* 缩略图地址 */
@property (nonatomic, copy) NSString *thumbnailUrl;

/* 原图二进制流 */
@property (nonatomic, strong) NSData *originalData;

/* 缩略图二进制流 */
@property (nonatomic, strong) NSData *thumbnailData;

+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end
