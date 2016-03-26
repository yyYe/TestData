//
//  AddAddressCee.m
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "AddAddressCell.h"

#define textFieldTapped(textField,tapped) [textField addTarget:self action:@selector(tapped) forControlEvents:UIControlEventEditingChanged];

@implementation AddAddressCell

- (void)createUI {
    nameLabel = [UILabel new];
    [nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:nameLabel];
    
    self.tfText = [UITextField new];
    self.tfText.delegate = self;
    self.tfText.font = fontSize(14);
//    textFieldTapped(self.tfText, tfTextTapped:);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.tfText];
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

- (void)setPersonal:(PersonalCenter *)personal {
    _personal = personal;
    nameLabel.text = personal.title;
    self.tfText.text = personal.text;
    self.tfText.placeholder = personal.placeholder;
    if ([personal.title isEqualToString:kPhoneTitle] || [personal.title isEqualToString:kZipCodeTitle]) {
        self.tfText.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        self.tfText.keyboardType = UIKeyboardTypeDefault;
    }
    if ([personal.title isEqualToString:kAreaTitle]) {
        self.tfText.enabled = NO;
        self.tfText.text = personal.placeholder;
    }
}

-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    if ([_personal.title isEqualToString:kNameTitle]){
        if (toBeString.length > 8) {
            textField.text = [toBeString substringToIndex:8];
        }
    } else if ([_personal.title isEqualToString:kPhoneTitle]) {
        if (toBeString.length > 11) {
            textField.text = [toBeString substringToIndex:11];
        }
    } else if ([_personal.title isEqualToString:kZipCodeTitle])  {
        if (toBeString.length > 6) {
            textField.text = [toBeString substringToIndex:6];
        }
    } else {
        if (toBeString.length > 1000) {
            textField.text = [toBeString substringToIndex:1000];
        }
    }
    self.value(textField.text);
}

- (void)tfTextTapped:(UITextField *)textField {
    self.value(textField.text);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditing:YES];
    return YES;
}

@end
