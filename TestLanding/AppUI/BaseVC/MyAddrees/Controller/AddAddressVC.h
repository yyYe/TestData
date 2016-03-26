//
//  AddAddressVC.h
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "CustomNavgationButtonVC.h"
#import "MyAddress.h"

@interface AddAddressVC : CustomNavgationButtonVC

@property (nonatomic, strong) MyAddress *address;
@property (nonatomic, strong) NSIndexPath *addressIndexPath;

@end
