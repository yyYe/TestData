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
    
    ivLogo = [UIImageView new];
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
    
    UIView *view = [UIView new];
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor grayColor].CGColor;
    [self addSubview:view];
    
    UIButton *defaultBtn = [UIButton new];
    targerTapped(defaultBtn, defaultButtonTapped);
    [self addSubview:defaultBtn];
    
    clickBtn = [UIButton new];
    clickBtn.enabled = NO;
    buttonImage(clickBtn, @"defaultAddressUncheck");
    [defaultBtn addSubview:clickBtn];
    
    defaultLabel = [UILabel new];
    defaultLabel.text = @"设为默认";
    [defaultBtn addSubview:defaultLabel];
    
    UIButton *editBtn = [UIButton new];
    targerTapped(editBtn, editButtonTapped);
    [self addSubview:editBtn];
    
    UIImageView *ivEdit = [UIImageView new];
    ivEdit.image = [UIImage imageNamed:@"editAddress"];
    [editBtn addSubview:ivEdit];
    
    editLabel = [UILabel new];
    editLabel.text = @"编辑";
    [editBtn addSubview:editLabel];
    
    UIButton *deleteBtn = [UIButton new];
    targerTapped(deleteBtn, deleteButtonTapped);
    [self addSubview:deleteBtn];
    
    UIImageView *ivDelete = [UIImageView new];
    ivDelete.image = [UIImage imageNamed:@"deleteAddress"];
    [deleteBtn addSubview:ivDelete];
    
    deleteLabel = [UILabel new];
    deleteLabel.text = @"删除";
    [deleteBtn addSubview:deleteLabel];
    
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
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(addressLabel.mas_bottom).offset(5);
        make.height.equalTo(@1);
    }];
    
    [defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(5);
        make.left.equalTo(nameLabel).offset(5);
        make.width.equalTo(@110);
        make.height.equalTo(@44);
    }];
    
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(defaultBtn);
        make.centerY.equalTo(defaultBtn);
    }];
    
    [defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(clickBtn.mas_right).offset(5);
        make.centerY.equalTo(clickBtn);
    }];
    
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(defaultBtn);
        make.left.equalTo(defaultBtn.mas_right).offset(10);
        make.width.equalTo(@80);
    }];
    
    [ivEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(editBtn);
        make.centerY.equalTo(editBtn);
    }];
    
    [editLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ivEdit.mas_right).offset(5);
        make.centerY.equalTo(editBtn);
    }];
    
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(defaultBtn);
        make.left.equalTo(editBtn.mas_right).offset(10);
        make.width.equalTo(@80);
    }];
    
    [ivDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(deleteBtn);
        make.centerY.equalTo(deleteBtn);
    }];
    
    [deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ivDelete.mas_right).offset(5);
        make.centerY.equalTo(ivDelete);
    }];
}

- (void)setAddress:(MyAddress *)address {
    if (address.defaultAddress == YES) {
        
    } else {
        ivLogo.image = [UIImage imageNamed:@"defaultAddress"];
        buttonImage(clickBtn, @"gou");
    }
    nameLabel.text = address.fullname;
    phoneLabel.text = address.mobliePhone;
    addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",address.prov,address.city,address.areaname,address.street];
}

- (void)defaultButtonTapped {
    if (self.address.defaultAddress == YES) {
        ivLogo.image = [UIImage imageNamed:@"defaultAddress"];
        buttonImage(clickBtn, @"gou");
        self.defaultTapped();
    } else {
        self.defaultTapped();
    }
    
}

- (void)editButtonTapped {
    self.edit();
}

- (void)deleteButtonTapped {
    
}

@end
