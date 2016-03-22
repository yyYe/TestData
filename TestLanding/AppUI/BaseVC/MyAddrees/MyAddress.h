//
//  MyAddress.h
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAddress : NSObject

@property (nonatomic, strong) NSString *fullname; //收件人
@property (nonatomic, strong) NSString *mobilephone; // 手机号
@property (nonatomic, strong) NSString *address; // 详细地址
@property (nonatomic, strong) NSString *postCode; // 邮票
@property (nonatomic, strong) NSString *prov; // 省
@property (nonatomic, strong) NSString *city; // 市
@property (nonatomic, strong) NSString *areaname; // 区

@end
