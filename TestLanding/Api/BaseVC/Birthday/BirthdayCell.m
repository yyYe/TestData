//
//  BirthdayCell.m
//  TestLanding
//
//  Created by loufq on 16/3/21.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BirthdayCell.h"

@implementation BirthdayCell

- (void)createUI {
    nameLabel = [UILabel new];
    nameLabel.text = @"生日";
    [nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [nameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:nameLabel];
    
    self.birthdayLabel = [UILabel new];
    //    tfName.text = self.labelItem.details;
    [self addSubview:self.birthdayLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
    }];
    
    [self.birthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLabel);
        make.left.equalTo(nameLabel.mas_right).offset(10);
    }];
}

- (void)setPerson:(PersonBase *)person {
    self.birthdayLabel.text = person.birthday;
}

- (void)setMother:(Mother *)mother {
    self.birthdayLabel.text = mother.birthday;
}

@end
