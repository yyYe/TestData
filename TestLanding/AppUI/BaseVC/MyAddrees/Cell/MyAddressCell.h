//
//  MyAddressCell.h
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseCell.h"
#import "MyAddress.h"

typedef void(^defaultTapped)();
typedef void(^editTapped)();
typedef void(^deleteTapped)();

@interface MyAddressCell : BaseCell {
    UILabel *nameLabel;
    UILabel *phoneLabel;
    UILabel *addressLabel;
    UILabel *defaultLabel;
    UILabel *editLabel;
    UILabel *deleteLabel;
    UIImageView *ivLogo;
    UIButton *clickBtn;
}
@property (nonatomic, strong) MyAddress *address;
@property (nonatomic, strong) defaultTapped defaultTapped;
@property (nonatomic, strong) editTapped edit;
@property (nonatomic, strong) deleteTapped deleteTapped;
@end
