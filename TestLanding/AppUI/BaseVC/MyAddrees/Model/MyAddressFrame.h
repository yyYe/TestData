//
//  FGMyAddressFrame.h
//  YiMaMa
//
//  Created by LWF on 16/2/4.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+Extension.h"
#import "MyAddress.h"

#define cellWidthBorder 10
#define cellHeightBorder 20
#define nameFont [UIFont boldSystemFontOfSize:15]
#define phoneFont [UIFont systemFontOfSize:13]
#define addressFont [UIFont systemFontOfSize:13]

@interface MyAddressFrame : NSObject

@property (nonatomic, strong) MyAddress *item;

@property (nonatomic, assign, readonly) CGRect nameLabelF;
@property (nonatomic, assign, readonly) CGRect addressLabelF;
@property (nonatomic, assign, readonly) CGRect phoneLabelF;
@property (nonatomic, assign, readonly) CGRect defaultAddressViewF;
@property (nonatomic, assign, readonly) CGRect toolBarF;
@property (nonatomic, assign, readonly) CGRect topBgF;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
