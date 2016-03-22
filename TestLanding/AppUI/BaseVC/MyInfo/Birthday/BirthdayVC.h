//
//  BirthdayVC.h
//  TestLanding
//
//  Created by loufq on 16/3/21.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "CustomNavgationButtonVC.h"

@interface BirthdayVC : CustomNavgationButtonVC 

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) PersonBase *person;

@end
