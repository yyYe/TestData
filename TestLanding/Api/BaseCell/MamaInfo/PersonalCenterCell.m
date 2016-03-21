//
//  PersonalCenterCell.m
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "PersonalCenterCell.h"

@implementation PersonalCenterCell

- (void)createUI {
    
}

- (void)setPersonalCenter:(PersonalCenter *)personalCenter {
    self.personalCenter = personalCenter;
    self.imageView.image = [UIImage imageNamed:personalCenter.icon];
    self.textLabel.text = personalCenter.title;
}

@end
