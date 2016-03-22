//
//  MyOrder.h
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrder : NSObject

@property (nonatomic, strong) NSString *orderId; //订单编号
@property (nonatomic, strong) NSString *cfTitle; //众筹标题
@property (nonatomic, strong) NSString *cfPicture; //图片
@property (nonatomic, strong) NSString *sizeName; //众筹尺码

@property (nonatomic, strong) NSNumber *cfEndTime; //众筹结束时间
@property (nonatomic, strong) NSNumber *price; //单价total
@property (nonatomic, strong) NSNumber *total; //总金额

@property (nonatomic, assign) NSInteger orderSta; //众筹状态
@property (nonatomic, assign) NSInteger num; //订单数量

@end
