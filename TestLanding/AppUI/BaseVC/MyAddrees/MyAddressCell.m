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
    
    UILabel *nameLabel = [UILabel new];
    [self addSubview:nameLabel];
    
    UILabel *addresslabel = [UILabel new];
    [self addSubview:addresslabel];
    
    [ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self).offset(5);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(5);
    }];
    
    [addresslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel).offset(5);
        make.left.equalTo(nameLabel);
    }];
}

@end
