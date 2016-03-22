//
//  BabyAddInfoCell.m
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BabyAddInfoCell.h"

@implementation BabyAddInfoCell

- (void)createUI {
    self.avatar = [UIImageView new];
    [self addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-30);
    }];
}

- (void)setBabyDetails:(PersonalCenter *)babyDetails {
    self.textLabel.text = babyDetails.title;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://res.yimama.com.cn/media/%@",babyDetails.avatar]]];
}

@end
