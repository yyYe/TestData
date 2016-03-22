//
//  BabySexVC.h
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "CustomNavgationButtonVC.h"
@class PersonBase;

typedef void(^returnSex)(NSInteger sex);

@interface BabySexVC : CustomNavgationButtonVC

@property (nonatomic, strong) returnSex sexNumber;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) PersonBase *person;
@property (nonatomic, strong) UIImageView *checkView;
@property (nonatomic, assign) NSInteger selectedRow;

@end
