//
//  FGMyWorkCell.m
//  YiMaMa
//
//  Created by loufq on 16/3/1.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import "MyWorkCell.h"

@interface MyWorkCell(){
    UIImageView* ivMain;
    UILabel* lblLine1;
    UILabel* lblLine2;
    UILabel* lblLine3;
    UILabel* lblLine4;
    
    UILabel* lblTipStatus;
    UILabel* lblTipCountDown;
}

@end


@implementation MyWorkCell

-(void)createUI{
    UIView* vSplit =[UIView new];
    vSplit.backgroundColor = YMMNavItemGrayColor;
    [self.contentView addSubview:vSplit];
    [vSplit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.equalTo(@8);
    }];
    
    ivMain =[UIImageView new];
    ivMain.contentMode = UIViewContentModeScaleAspectFit;
    ivMain.clipsToBounds = YES;
    [self.contentView addSubview:ivMain];
    [ivMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(vSplit.mas_bottom);
        make.bottom.equalTo(self.contentView);
        make.width.equalTo(@90);
    }];
    
    lblLine1 =[UILabel new];
    lblLine1.textColor = YMMNavItemTitleColor;
    lblLine2 =[UILabel new];
    lblLine2.textColor = YMMNavItemSubTitleColor;
    lblLine2.numberOfLines =2;
    lblLine3 =[UILabel new];
    lblLine3.textColor = YMMNavItemPriceColor;
    lblLine4 =[UILabel new];
    lblLine4.textColor = YMMNavItemInfoColor;
    [self.contentView addSubview:lblLine1];
    [self.contentView addSubview:lblLine2];
    [self.contentView addSubview:lblLine3];
    [self.contentView addSubview:lblLine4];
    lblLine1.font =[UIFont boldSystemFontOfSize:14];
    lblLine2.font =[UIFont systemFontOfSize:12];
    lblLine3.font =[UIFont systemFontOfSize:14];
    lblLine4.font =[UIFont systemFontOfSize:12];
    
    
    [lblLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ivMain.mas_right).offset(8);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(ivMain).offset(3);
        make.height.equalTo(@20);
    }];
    
    [lblLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lblLine1);
        make.bottom.equalTo(ivMain).offset(-5);
        make.height.equalTo(@20);
    }];
    
    
    [lblLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lblLine1);
        make.top.equalTo(lblLine1.mas_bottom);
        make.height.equalTo(@35);
    }];
    
    [lblLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lblLine1);
        make.top.equalTo(lblLine2.mas_bottom);
        make.bottom.equalTo(lblLine4.mas_top);
    }];
    
    lblTipStatus =[UILabel new];
    lblTipStatus.clipsToBounds = YES;
    lblTipStatus.textAlignment = NSTextAlignmentCenter;
    lblTipStatus.font =[UIFont systemFontOfSize:12];
    lblTipCountDown =[UILabel new];
    lblTipCountDown.clipsToBounds = lblTipStatus.clipsToBounds;
    lblTipCountDown.textAlignment = NSTextAlignmentCenter;
    lblTipCountDown.font = lblTipStatus.font;
    [self.contentView addSubview:lblTipStatus];
    [self.contentView addSubview:lblTipCountDown];
    [lblTipStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    lblTipStatus.layer.borderWidth = 1;
    lblTipStatus.layer.cornerRadius = 4;
    lblTipStatus.layer.borderColor = FGColor(244, 113, 160).CGColor;
    lblTipStatus.backgroundColor = FGColor(254, 224, 235);
    lblTipStatus.textColor = FGColor(244, 113, 160);
    lblTipCountDown.layer.borderWidth = 1;
    lblTipCountDown.layer.cornerRadius = 4;
    lblTipCountDown.layer.borderColor = FGColor(244, 113, 160).CGColor;
    lblTipCountDown.backgroundColor = FGColor(254, 224, 235);
    lblTipCountDown.textColor = FGColor(244, 113, 160);
    [lblTipCountDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lblTipStatus);
        make.bottom.equalTo(lblTipStatus);
        make.height.equalTo(@20);
        make.width.equalTo(@90);
    }];
}

@end
