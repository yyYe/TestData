//
//  UIImage+Extension.m
//  lx
//
//  Created by LWF on 15/11/13.
//  Copyright (c) 2015年 LWF. All rights reserved.
//

#import "UIImage+Extension.h"
const CGFloat kMaxImageWidth = 640;// 140.0;

@implementation UIImage (Extension)

+ (UIImage *)resizableImageWithName:(NSString *)name{
    return [self resizableImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizableImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:left*image.size.width topCapHeight:top*image.size.height];
}





+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (UIImage *)generateThumbnail:(CGSize)thumbnailSize{
    // Create a thumbnail version of the image for the event object.
    CGSize size = self.size;
    CGSize croppedSize;
    CGFloat ratio = thumbnailSize.width;//这个是设置转换后图片的尺寸大小
    CGFloat offsetX = 0.0;
    CGFloat offsetY = 0.0;
    
    // check the size of the image, we want to make it
    // a square with sides the size of the smallest dimension
    if (size.width > size.height) {
        offsetX = (size.height - size.width) / 2;
        croppedSize = CGSizeMake(size.height, size.height);
    } else {
        offsetY = (size.width - size.height) / 2;
        croppedSize = CGSizeMake(size.width, size.width);
    }
    
    // Crop the image before resize
    CGRect clippedRect = CGRectMake(offsetX * -1, offsetY * -1, croppedSize.width, croppedSize.height);
    //裁剪图片
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], clippedRect);
    // Done cropping
    
    // Resize the image
    CGRect rect = CGRectMake(0.0, 0.0, ratio, ratio);
    
    UIGraphicsBeginImageContext(rect.size);
    [[UIImage imageWithCGImage:imageRef] drawInRect:rect];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Done Resizing
    
    CGImageRelease(imageRef);
    
    return thumbnail;
}


- (UIImage *)imageByScalingToMaxSize:(CGFloat)maxWidth{
    if (self.size.width < maxWidth){
        return self;
    }
    
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    
    if (self.size.width > self.size.height) {
        btHeight = maxWidth;
        btWidth = self.size.width * (maxWidth / self.size.height);
    } else {
        btWidth = maxWidth;
        btHeight = self.size.height * (maxWidth / self.size.width);
    }
    
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    
    return [self imageByScalingAndCroppingForSize:targetSize];
}

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    //    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#if 0
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize{
    
    UIGraphicsBeginImageContext(targetSize);
    [self drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#endif



//**
- (UIImage *)imageByScalingToSize:(CGSize)targetSize{
    UIImage *targetImage = nil;
    
    return targetImage;
}

@end
