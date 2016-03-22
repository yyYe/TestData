//
//  MamaInfoCell.m
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "MamaInfoCell.h"

@implementation MamaInfoCell

- (void)createUI {
    detailsLabel = [UILabel new];
    detailsLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:detailsLabel];
    [detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(70);
        make.right.equalTo(self).offset(-30);
    }];
}

- (void)setLabelItem:(MeLableItem *)labelItem {
    _labelItem = labelItem;
    self.textLabel.text = labelItem.title;
    
    NSString *details = labelItem.details;
    if ([labelItem.title isEqualToString:kPhone]) {
        details = [details stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    detailsLabel.text = details;
}

@end
