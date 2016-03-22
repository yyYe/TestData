//
//  FGMyWorkCell.m
//  YiMaMa
//
//  Created by loufq on 16/3/1.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import "MyOrderCell.h"

@interface MyOrderCell() {
    UIImageView *ivLogo;
    UILabel *orderId;
    UILabel *total;
    UILabel *cfTitle;
    UILabel *orderSta;
    UILabel *price;
    UILabel *sizeName;
    UILabel *num;
}

@end


@implementation MyOrderCell

-(void)createUI{
    orderId = [UILabel new];
    orderId.font = fontSize(14);
    [self addSubview:orderId];
    
    orderSta = [UILabel new];
    orderSta.font = fontSize(14);
    [self addSubview:orderSta];
    
    ivLogo = [UIImageView new];
    [self addSubview:ivLogo];
    
    cfTitle = [UILabel new];
    cfTitle.textColor = [UIColor lightGrayColor];
    cfTitle.font = fontSize(15);
    [self addSubview:cfTitle];
    
    sizeName = [UILabel new];
    sizeName.textColor = [UIColor grayColor];
    sizeName.font = fontSize(12);
    [self addSubview:sizeName];
    
    num = [UILabel new];
    num.textColor = [UIColor grayColor];
    num.font = fontSize(12);
    [self addSubview:num];
    
    price = [UILabel new];
    price.textColor = [UIColor purpleColor];
    price.font = fontSize(14);
    [self addSubview:price];
    
    total = [UILabel new];
    total.textColor = [UIColor purpleColor];
    total.font = fontSize(14);
    [self addSubview:total];
    
    [orderId mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
    }];
    
    [orderSta mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(orderId);
        make.right.equalTo(self).offset(-10);
    }];
    
    [ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderId.mas_bottom).offset(20);
        make.left.equalTo(self).offset(20);
        make.height.equalTo(@80);
        make.width.equalTo(@60);
    }];
    
    [cfTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ivLogo);
        make.left.equalTo(ivLogo.mas_right).offset(20);
    }];
    
    [sizeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(price.mas_top);
        make.left.equalTo(cfTitle);
    }];
    
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(sizeName);
        make.left.equalTo(sizeName.mas_right).offset(10);
    }];
    
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ivLogo);
        make.left.equalTo(sizeName);
    }];
    
    [total mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(price.mas_bottom).offset(20);
        make.right.equalTo(orderSta);
    }];
}

- (void)setMyOrder:(MyOrder *)myOrder {
    orderId.text = myOrder.orderId;
    orderSta.text = myOrder.orderSta == 1 ? @"待付款" : @"待发货";
    [ivLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://res.yimama.com.cn/media/%@",myOrder.cfPicture]]];
    cfTitle.text = myOrder.cfTitle;
    sizeName.text = myOrder.sizeName;
    num.text = [NSString stringWithFormat:@"%d",myOrder.num];
    price.text = [myOrder.price stringValue];
    total.text = [myOrder.total stringValue];
}

@end
