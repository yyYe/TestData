//
//  MyAddressCell.m
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "MyAddressCell.h"

@implementation MyAddressCell

- (void)createUI {
    UIImageView *ivLogo = [UIImageView new];
    ivLogo.image = [UIImage imageNamed:@"defaultAddress"];
    [self addSubview:ivLogo];
    
    nameLabel = [UILabel new];
    [self addSubview:nameLabel];
    
    addressLabel = [UILabel new];
    [self addSubview:addressLabel];
    
    [ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self).offset(5);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(5);
    }];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(5);
        make.left.equalTo(nameLabel);
    }];
}

- (void)setAddress:(MyAddress *)address {
    nameLabel.text = address.fullname;
    addressLabel.text = address.street;
}

@end
