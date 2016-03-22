//
//  PersonalInfoCell.m
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "PersonalInfoCell.h"

static NSInteger const kAvatarSize = 70;

@interface PersonalInfoCell () {
    UIImageView *ivAvatar;
    UILabel *level;
    UILabel *babyName;
    UILabel *babyAgeDesc;
    UILabel *userSig;
}

@end

@implementation PersonalInfoCell

- (void)createUI {
    ivAvatar = [UIImageView new];
    ivAvatar.layer.masksToBounds = YES;
    ivAvatar.layer.cornerRadius = kAvatarSize/2;
    [self addSubview:ivAvatar];
    
    level = [UILabel new];
    level.textColor = [UIColor purpleColor];
    level.font = [UIFont systemFontOfSize:12];
    [self addSubview:level];
    
    babyName = [UILabel new];
    [babyName setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [babyName setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    babyName.font = [UIFont systemFontOfSize:13];
    [self addSubview:babyName];
    
    babyAgeDesc = [UILabel new];
    babyAgeDesc.textColor = [UIColor grayColor];
    babyAgeDesc.font = [UIFont systemFontOfSize:14];
    [self addSubview:babyAgeDesc];
    
    userSig = [UILabel new];
    userSig.numberOfLines = 2;
    userSig.font = [UIFont systemFontOfSize:13];
    [self addSubview:userSig];
    
    [ivAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(5);
        make.width.height.equalTo(@(kAvatarSize));
    }];
    
    [level mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ivAvatar);
        make.left.equalTo(ivAvatar.mas_right).offset(15);
    }];
    
    [babyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(level.mas_bottom);
        make.left.equalTo(ivAvatar.mas_right).offset(5);
    }];
    
    [babyAgeDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(babyName);
        make.left.equalTo(babyName.mas_right).offset(10);
    }];
    
    [userSig mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(babyName.mas_bottom);
        make.left.equalTo(babyName);
        make.right.equalTo(self).offset(-40);
    }];
}

- (void)setInfoItem:(MeInfoItem *)infoItem {
    [ivAvatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://res.yimama.com.cn/media/%@",infoItem.avatar]]];
    level.text = infoItem.levelName;
    babyName.text = infoItem.babyName;
    babyAgeDesc.text = infoItem.age;
    userSig.text = infoItem.introduction;
}

@end
