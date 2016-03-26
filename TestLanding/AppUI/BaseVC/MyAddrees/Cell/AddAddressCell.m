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
    
    self.tfText = [LimitTextField new];
    self.tfText.delegate = self;
    self.tfText.font = fontSize(14);
    [self.tfText addTarget:self action:@selector(tfTextTapped:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:self.tfText];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self.tfText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(10);
        make.centerY.equalTo(nameLabel);
        make.right.equalTo(self).offset(-1);
    }];
}

- (void)setPersonalCenter:(PersonalCenter *)personalCenter {
    nameLabel.text = personalCenter.title;
    self.tfText.text = personalCenter.text;
    self.tfText.placeholder = personalCenter.placeholder;
    if ([personalCenter.title isEqualToString:kPhoneTitle] || [personalCenter.title isEqualToString:kZipCodeTitle]) {
        self.tfText.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        self.tfText.keyboardType = UIKeyboardTypeDefault;
    }
    if ([personalCenter.title isEqualToString:kAreaTitle]) {
        self.tfText.enabled = NO;
        self.tfText.text = personalCenter.placeholder;
    }
}

- (void)tfTextTapped:(UITextField *)textField {
    self.value(textField.text);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditing:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location >= 11) {
        return NO;
    }
    return YES;
}

@end
