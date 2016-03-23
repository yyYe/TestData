//
//  MeBabyInfoItem.h
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "PersonalCenter.h"
#import "Gender.h"

@interface MeBabyInfoItem : PersonalCenter

//@property (nonatomic, strong) NSString *Avatar;
@property (nonatomic, assign) Gender sex;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *birthday;

@end
