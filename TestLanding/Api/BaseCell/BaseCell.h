//
//  BaseCell.h
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "PersonalCenter.h"
#import "MeLableItem.h"

@interface BaseCell : UITableViewCell

@property (nonatomic, strong) PersonalCenter *personalCenter;
- (void)createUI;
@end
