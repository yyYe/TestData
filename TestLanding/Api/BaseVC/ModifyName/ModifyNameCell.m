//
//  ModifyNameCell.m
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "ModifyNameCell.h"

@implementation ModifyNameCell

- (void)createUI {
    nameLabel = [UILabel new];
    nameLabel.text = @"昵称";
    [nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [nameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:nameLabel];
    
    self.tfName = [UITextField new];
    self.tfName.placeholder = @"请输入:";
    self.tfName.delegate = self;
    [self.tfName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    tfName.text = self.labelItem.details;
    [self addSubview:self.tfName];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
    }];
    
    [self.tfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLabel);
        make.left.equalTo(nameLabel.mas_right).offset(10);
        make.right.equalTo(self).offset(-20);
    }];
    
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSLog(@"%@",textField);
    self.tfContent(textField.text);
}

- (void)setLabelItem:(MeLableItem *)labelItem {
    nameLabel.text = labelItem.title;
    self.tfName.placeholder = @"请输入:";
    self.tfName.text = labelItem.details;
}

@end
