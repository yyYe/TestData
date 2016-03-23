//
//  FGAddressToolBar.h
//  YiMaMa
//
//  Created by LWF on 16/2/4.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressToolBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *setDefaultBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

+ (instancetype)toolBar;

@end
