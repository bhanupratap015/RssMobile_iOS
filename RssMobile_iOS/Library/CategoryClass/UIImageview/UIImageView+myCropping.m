//
//  UIImageView+myCropping.m
//  Flashagram
//
//  Created by Bhanu Pratap on 17/03/16.
//  Copyright © 2016 Teknowledge Software. All rights reserved.
//

#import "UIImageView+myCropping.h"

@implementation UIImageView (myCropping)

+ (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGRect)newSize {
    
//    //make a new square size, that is the resized imaged width
//    CGSize sz = CGSizeMake(newSize.size.width, newSize.size.height);
//    
//    //make the final clipping rect based on the calculated values
//    CGRect clipRect = CGRectMake(newSize.origin.x, newSize.origin.y,
//                                 newSize.size.width ,
//                                 newSize.size.height);
//
////    CGRect clipRect = CGRectMake(0, 0,
////                                 100 ,100);
////                                 newSize.size.height);
//
//    //start a new context, with scale factor 0.0 so retina displays get
//    //high quality image
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
//        UIGraphicsBeginImageContextWithOptions(sz, YES, 0);
//    } else {
//        UIGraphicsBeginImageContext(sz);
//    }
//    UIRectClip(clipRect);
//    [image drawInRect:clipRect];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], newSize);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return cropped;
}

+ (UIImage*) screenShotTheArea:(CGRect)area inView:(UIView*)view{
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(area.size.width, area.size.height), NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(view.bounds.size);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, -area.origin.x, -area.origin.y);
    [view.layer renderInContext:c];
    UIImage* thePrintScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return thePrintScreen;
}


@end
