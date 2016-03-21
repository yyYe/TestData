//
//  BabyDetailsCell.m
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BabyDetailsCell.h"

static NSInteger const kAvatarSize = 70;

@implementation BabyDetailsCell

- (void)createUI {
    avatar = [UIImageView new];
    avatar.layer.masksToBounds = YES;
    avatar.layer.cornerRadius = kAvatarSize/2;
    [self addSubview:avatar];
    [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.width.height.equalTo(@(kAvatarSize));
    }];
    
    babyName = [UILabel new];
    [self addSubview:babyName];
    [babyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatar);
        make.left.equalTo(avatar.mas_right).offset(20);
    }];
    
    UILabel *sexLabel = [UILabel new];
    sexLabel.text = @"性别：";
    [self addSubview:sexLabel];
    
    babySex = [UILabel new];
    [self addSubview:babySex];
    
    [sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(avatar);
        make.left.equalTo(babyName);
    }];
    
    [babySex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sexLabel);
        make.left.equalTo(sexLabel.mas_right).offset(10);
    }];
    
    UILabel *birthdayLabel = [UILabel new];
    birthdayLabel.text = @"生日：";
    [self addSubview:birthdayLabel];
    
    babyBirthday = [UILabel new];
    [self addSubview:babyBirthday];
    
    [birthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(avatar);
        make.left.equalTo(babyName);
    }];
    
    [babyBirthday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(birthdayLabel.mas_right).offset(10);
        make.bottom.equalTo(birthdayLabel);
    }];
}

- (void)setBabyItem:(MeBabyInfoItem *)babyItem {
    avatar.image = [UIImage imageNamed:@"default-avatar"];
    babyName.text = babyItem.nickName;
    babySex.text = babyItem.sex;
//    babyBirthday.text = babyItem.birthday;
}

@end
