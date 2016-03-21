//
//  CustomNavgationButtonVC.h
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseVC.h"

@interface CustomNavgationButtonVC : BaseVC

- (void)setupNavLeftBtnWithTitle:(NSString *)title;
- (void)setupNavRightBtnWithTitle:(NSString *)title;
- (void)rightBtnAction;

@end
