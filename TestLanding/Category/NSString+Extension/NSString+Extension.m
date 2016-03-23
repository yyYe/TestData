//
//  NSString+Extension.m
//  lx
//
//  Created by LWF on 15/11/15.
//  Copyright (c) 2015年 LWF. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGFloat)widthWithFont:(UIFont *)font{
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    return textSize.width;
}

- (CGFloat)heightWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    return textSize.height;
}



- (NSString *)formatMobilephonenumber{
    NSMutableString *phone = [NSMutableString stringWithString:self];
    NSString *number = @"0123456789";
    
    for(int i = 0; i < phone.length; i ++){
        NSString *character = [phone substringWithRange:NSMakeRange(i, 1)];
        if ( (i == 0) && [character isEqualToString:@"+"]) {
            continue;
        }
        
        if ([number rangeOfString:character].length == 0) {
            [phone deleteCharactersInRange:NSMakeRange(i, 1)];
            i = 0;
        }
    }
    
    return phone;
}

- (BOOL)isAllNumber{
    NSString *number = @"0123456789";
    for(int i = 0; i < self.length; i ++){
        NSString *str = [self substringWithRange:NSMakeRange(i, 1)];
        if ([number rangeOfString:str].length == 0) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isValidPhoneNumber{
    if (self.length != 11) return NO;
    NSString *str = [self substringWithRange:NSMakeRange(0, 1)];
    if (![str isEqualToString:@"1"]) return NO;
    if (![self isAllNumber]) return NO;
    return YES;
}

@end
