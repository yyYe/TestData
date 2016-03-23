//
//  BabySexVC.h
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "CustomNavgationButtonVC.h"
@class PersonBase;

@interface BabySexVC : CustomNavgationButtonVC

@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) PersonBase *person;
@property (nonatomic, strong) UIImageView *checkView;
@property (nonatomic, assign) NSInteger selectedRow;

@end
