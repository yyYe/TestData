//
//  FGMyAddressFrame.m
//  YiMaMa
//
//  Created by LWF on 16/2/4.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import "MyAddressFrame.h"

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@implementation MyAddressFrame

- (void)setItem:(MyAddress *)item{
    _item = item;
    
    CGFloat widthSide = 10;
    CGFloat heightSide = 5;
    CGFloat lableWideSpace = 5;
    CGFloat lableHeightSpace = 5;
    CGFloat cellWidth = SCREEN_WIDTH - 2*cellWidthBorder;
    
    CGFloat nameX = widthSide;
    CGFloat nameY = heightSide;
    CGFloat nameW = [item.fullname widthWithFont:nameFont];
    CGFloat nameH = nameFont.lineHeight;
    _nameLabelF = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat phoneW = [item.mobliePhone widthWithFont:phoneFont];
    CGFloat phoneH = phoneFont.lineHeight;
    CGFloat phoneX = nameX + nameW + 2 * lableWideSpace;
    CGFloat phoneY = nameY + 0.5*(nameH - phoneH);
    _phoneLabelF = CGRectMake(phoneX, phoneY, phoneW, phoneH);
    
    
    CGFloat defaultW = 22;
    CGFloat defaultH = defaultW;
    CGFloat defaultX = cellWidth - defaultW;
    CGFloat defaultY = 0;
    _defaultAddressViewF = CGRectMake(defaultX, defaultY, defaultW, defaultH);
    
    CGFloat addressX = nameX;
    CGFloat addressY = nameY + nameH + lableHeightSpace;
    CGFloat addressW = cellWidth - 2 * widthSide;
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@ %@",item.prov,item.city,item.areaname,item.street];
    CGFloat addressH = [address heightWithFont:addressFont maxWidth:addressW];
    _addressLabelF = CGRectMake(addressX, addressY, addressW, addressH);
    
    CGFloat topBgH = CGRectGetMaxY(_addressLabelF) + lableHeightSpace;
    _topBgF = CGRectMake(0, 0, cellWidth, topBgH);
    
    //工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarY = topBgH;
    CGFloat toolBarW = cellWidth;
    CGFloat toolBarH = 40;
    _toolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    _cellHeight = CGRectGetMaxY(_toolBarF) + cellHeightBorder;
}

@end
