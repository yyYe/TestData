//
//  AddAddressCee.h
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseCell.h"

#define kNameTitle @"姓名"
#define kAreaTitle @"省市区"
#define kPhoneTitle @"手机"
#define kZipCodeTitle @"邮编"
typedef void(^returnTextFieldValue)(NSString *value);

@interface LimitTextField : UITextField

@end

@interface AddAddressCell : BaseCell <UITextFieldDelegate> {
    UILabel *nameLabel;
}

@property (nonatomic, strong) UITextField *tfText;
@property (nonatomic, strong) returnTextFieldValue value;
@property (nonatomic, strong) PersonalCenter *personal;

@end
