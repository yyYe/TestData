//
//  ModifyNameCell.h
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseCell.h"

typedef void(^getTextFieldContent)(NSString *tfText);

@interface ModifyNameCell : BaseCell <UITextFieldDelegate> {
    UILabel *nameLabel;
}

@property (nonatomic, strong) UITextField *tfName;
@property (nonatomic, strong) getTextFieldContent tfContent;

@end
