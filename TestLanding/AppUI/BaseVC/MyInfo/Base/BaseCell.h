//
//  BaseCell.h
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstMacro.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>
#import "PersonalCenter.h"
#import "MeLableItem.h"
#import "Mother.h"
#import "PersonBase.h"

#define fontSize(size) [UIFont systemFontOfSize:size]

@interface BaseCell : UITableViewCell

@property (nonatomic, strong) PersonalCenter *personalCenter;
@property (nonatomic, strong) PersonBase *person;
- (void)createUI;
@end