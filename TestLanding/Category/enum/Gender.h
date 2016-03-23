//
//  Gender.h
//  YiMaMa
//
//  Created by LWF on 16/1/17.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#ifndef Gender_h
#define Gender_h

typedef enum {
    GenderWoman, //(0女, 1男)
    GenderMan,
    GenderUnknow
}Gender;

typedef enum {
    UserTypeCommon = 1, //普通用户
    UserTypeCustomerService, //客服
    UserTypeMother, //妈妈
    UserTypeDesigner //设计师
}UserType;

typedef enum {
    isYES = 1, //(1是修改, 0不是)
    isNO
}isModify;

//(item.sex == GenderMan) ? @"男" : @"女"
//(item.sex == GenderMan) ? @"小王纸" : @"小公举"

#endif /* Gender_h */
