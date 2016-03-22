//
//  AddAddressCee.h
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseCell.h"

typedef void(^returnTextFieldValue)(NSString *value);

@interface AddAddressCell : BaseCell <UITextFieldDelegate> {
    UILabel *nameLabel;
    UITextField *tfText;
}

@property (nonatomic, strong) returnTextFieldValue value;

@end
