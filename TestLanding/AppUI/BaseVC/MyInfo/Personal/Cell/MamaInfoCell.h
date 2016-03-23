//
//  MamaInfoCell.h
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseCell.h"
#import "MeLableItem.h"

#define kPhone @"手机"
@interface MamaInfoCell : BaseCell {
    UILabel *detailsLabel;
}

@property (nonatomic, strong) MeLableItem *labelItem;
@end
