//
//  PersonBase.h
//  YiMaMa
//
//  Created by LWF on 16/1/26.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Safe.h"
#import "ImageItem.h"
#import "Gender.h"

//基类
@interface PersonBase : NSObject

/**   主键id    */
@property (nonatomic, copy) NSString *userId;

/**   用户唯一标识xuid   */
@property (nonatomic, copy) NSString *xuid;

/**   头像   */
@property (nonatomic, strong) ImageItem *avatar;
@property (nonatomic, strong) NSString *avatarString;

/**   baby只用nickName,目前baby没有name属性    */
@property (nonatomic, copy) NSString *name;

/**   如未设置就是手机号,后台处理    */
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) Gender gender;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *phoneNumber;

/**   签名   */
@property (nonatomic, copy) NSString *signature;

@property (nonatomic, copy) NSString *level; //等级  如:1、2、3...
@property (nonatomic, copy) NSString *levelName; //如: 宝妈1级

@property (nonatomic, copy) NSString *attentionNumber;
@property (nonatomic, copy) NSString *fansNumber;

+ (instancetype)personWithDict:(NSDictionary *)dict;

@end
