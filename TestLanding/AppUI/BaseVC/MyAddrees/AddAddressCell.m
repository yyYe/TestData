//
//  AddAddressCee.m
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "AddAddressCell.h"

@implementation AddAddressCell

- (void)createUI {
    nameLabel = [UILabel new];
    [nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:nameLabel];
    
    tfText = [UITextField new];
    tfText.delegate = self;
    tfText.font = fontSize(14);
    [tfText addTarget:self action:@selector(tfTextTapped:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:tfText];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [tfText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(10);
        make.centerY.equalTo(nameLabel);
        make.right.equalTo(self).offset(-1);
    }];
}

- (void)setPersonalCenter:(PersonalCenter *)personalCenter {
    nameLabel.text = personalCenter.title;
    tfText.placeholder = personalCenter.placeholder;
}

- (void)tfTextTapped:(UITextField *)textField {
    self.value(textField.text);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditing:YES];
    return YES;
}

@end
