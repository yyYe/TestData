//
//  MamaAvatarCell.m
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "MamaAvatarCell.h"

static NSInteger const kAvatarSize = 50;

@implementation MamaAvatarCell

- (void)createUI {
    self.avatar = [UIImageView new];
    self.avatar.layer.masksToBounds = YES; 
    self.avatar.layer.cornerRadius = kAvatarSize/2;
    [self addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-30);
        make.width.height.equalTo(@(kAvatarSize));
    }];
}

- (void)setPersonalCenter:(PersonalCenter *)personalCenter {
    self.textLabel.text = personalCenter.title;
    if (personalCenter.avatar == nil) {
        self.avatar.image = [UIImage imageNamed:@"default-avatar"];
    }else {
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://res.yimama.com.cn/media/%@",personalCenter.avatar]]];
//        self.avatar.image = [UIImage imageWithData:personalCenter.avatarData];
    }
}

@end
