//
//  BaseCell.h
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>
#import "ConstMacro.h"
#import "UIImage+Extension.h"
#import "PersonalCenter.h"
#import "MeLableItem.h"
#import "Mother.h"
#import "PersonBase.h"

#define fontSize(size) [UIFont systemFontOfSize:size]
#define targerTapped(button,buttonTapped) [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
#define buttonImage(button,image) [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];

@interface BaseCell : UITableViewCell

@property (nonatomic, strong) PersonalCenter *personalCenter;
@property (nonatomic, strong) PersonBase *person;
- (void)createUI;
@end
