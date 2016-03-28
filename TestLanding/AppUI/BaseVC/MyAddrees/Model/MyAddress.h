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
@property (nonatomic, strong) NSString *mobliePhone; // 手机号
@property (nonatomic, strong) NSString *deliveryid; // 用户地址id

@property (nonatomic, strong) NSString *street; // 街道
@property (nonatomic, strong) NSString *prov; // 省
@property (nonatomic, strong) NSString *city; // 市
@property (nonatomic, strong) NSString *areaname; // 区

@property (nonatomic, strong) NSString *postCode; // 邮票
@property (nonatomic, strong) NSString *provCode; //省编号
@property (nonatomic, strong) NSString *cityCode; //市编号
@property (nonatomic, strong) NSString *areaCode; //区编号

@property (nonatomic, strong) NSString *xuid;
//@property (nonatomic, strong) NSString *msgID;

@property (nonatomic, assign) BOOL defaultAddress; //0代表默认地址
@end
