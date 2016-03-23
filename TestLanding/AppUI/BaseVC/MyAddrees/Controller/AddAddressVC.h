//
//  AddAddressVC.h
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseVC.h"
#import "MyAddress.h"

typedef void(^refreshTableView)();

@interface AddAddressVC : BaseVC

@property (nonatomic, strong) refreshTableView refresh;
@property (nonatomic, strong) MyAddress *address;

@end
