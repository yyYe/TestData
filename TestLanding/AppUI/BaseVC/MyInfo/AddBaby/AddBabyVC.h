//
//  AddBabyVC.h
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "CustomNavgationButtonVC.h"
#import "MeBabyInfoItem.h"
#import "Baby.h"

@interface AddBabyVC : CustomNavgationButtonVC

@property (nonatomic, strong) MeBabyInfoItem *babyInfo;
@property (nonatomic, strong) Baby *baby;

@end
