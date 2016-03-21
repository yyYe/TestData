//
//  ModifyNameVC.h
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "CustomNavgationButtonVC.h"

@interface ModifyNameVC : CustomNavgationButtonVC {
    NSString *nameText;
}

@property (nonatomic, strong) MeLableItem *labelItem;
@property (nonatomic, strong) PersonBase *person;

@end
