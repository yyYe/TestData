//
//  NSString+Extension.h
//  lx
//
//  Created by LWF on 15/11/15.
//  Copyright (c) 2015年 LWF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**  计算只显示一行时的width  */
- (CGFloat)widthWithFont:(UIFont *)font;

/**  计算显示多行时的height  */
- (CGFloat)heightWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;


- (NSString *)formatMobilephonenumber;
- (BOOL)isAllNumber;
- (BOOL)isValidPhoneNumber;
@end
