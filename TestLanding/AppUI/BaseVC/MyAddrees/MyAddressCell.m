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
    
    phoneLabel = [UILabel new];
    [self addSubview:phoneLabel];
    
    addressLabel = [UILabel new];
    addressLabel.font = fontSize(13);
    addressLabel.textColor = [UIColor grayColor];
    addressLabel.numberOfLines = 0;
    [self addSubview:addressLabel];
    
    [ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(5);
    }];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(10);
        make.top.equalTo(nameLabel);
    }];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(5);
        make.left.equalTo(nameLabel);
        make.right.equalTo(self).offset(-10);
    }];
    
}

- (void)setAddress:(MyAddress *)address {
    nameLabel.text = address.fullname;
    phoneLabel.text = address.mobliePhone;
    addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",address.prov,address.city,address.areaname,address.street];
}

@end
