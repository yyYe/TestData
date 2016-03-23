//
//  MyAddressCell.h
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseCell.h"
#import "MyAddress.h"

@interface MyAddressCell : BaseCell {
    UILabel *nameLabel;
    UILabel *addressLabel;
}
@property (nonatomic, strong) MyAddress *address;
@end
