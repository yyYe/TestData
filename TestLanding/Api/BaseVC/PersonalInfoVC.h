//
//  TestVC.h
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseVC.h"

@interface PersonalInfoVC : BaseVC

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *xuid;
@property (nonatomic, strong) NSDictionary *dict;

@property (nonatomic, strong) Mother *mother;

@end
