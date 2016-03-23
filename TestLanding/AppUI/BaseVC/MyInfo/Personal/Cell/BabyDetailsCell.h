//
//  BabyDetailsCell.h
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseCell.h"
#import "MeBabyInfoItem.h"

@interface BabyDetailsCell : BaseCell {
    UIImageView *avatar;
    UILabel *babyName;
    UILabel *babySex;
    UILabel *babyBirthday;
}

@property (nonatomic, strong) MeBabyInfoItem *babyItem;

@end
