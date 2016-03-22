//
//  MeinfoItem.h
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "PersonalCenter.h"
#import "Gender.h"

@interface MeInfoItem : PersonalCenter

@property (nonatomic, assign) int level; //userRank  mama
@property (nonatomic, copy) NSString *levelName; //rankTitle  mama
@property (nonatomic, copy) NSString *age;  //babyAgeDesc
@property (nonatomic, copy) NSString *babyName; 
@property (nonatomic, assign) Gender sex;
@property (nonatomic, copy) NSString *introduction;  //userSig  mama

@end
