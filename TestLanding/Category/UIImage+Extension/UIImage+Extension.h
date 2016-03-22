//
//  UIImage+Extension.h
//  lx
//
//  Created by LWF on 15/11/13.
//  Copyright (c) 2015年 LWF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

//图片拉伸
+ (UIImage *)resizableImageWithName:(NSString *)name;
/**     left、top为0~1    */
+ (UIImage *)resizableImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;


+ (UIImage *)imageWithColor:(UIColor *)color;

//缩略图
- (UIImage *)generateThumbnail:(CGSize)thumbnailSize;

//等比例裁剪
- (UIImage *)imageByScalingToMaxSize:(CGFloat)maxWidth;

////把图片按照新大小进行裁剪，生成一个新图片
- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

////把图片做等比缩放，生成一个新图片
//- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;


//
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
@end
