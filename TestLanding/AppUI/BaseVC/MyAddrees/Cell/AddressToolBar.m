//
//  FGAddressToolBar.m
//  YiMaMa
//
//  Created by LWF on 16/2/4.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//


#import "UIImage+Extension.h"
#import "AddressToolBar.h"

@interface AddressToolBar()
@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@end

@implementation AddressToolBar

- (void)awakeFromNib{
    [self.setDefaultBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [self.editBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [self.deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    self.bgView.image = [UIImage resizableImageWithName:@"addressToolBarBg"];
}

+ (instancetype)toolBar{
    return [[[NSBundle mainBundle]loadNibNamed:@"AddressToolBar" owner:self options:nil]lastObject];
}

@end
