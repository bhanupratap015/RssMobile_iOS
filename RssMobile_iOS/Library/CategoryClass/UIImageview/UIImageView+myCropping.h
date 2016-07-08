//
//  UIImageView+myCropping.h
//  Flashagram
//
//  Created by Bhanu Pratap on 17/03/16.
//  Copyright © 2016 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (myCropping)

+ (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGRect)newSize;
+ (UIImage*) screenShotTheArea:(CGRect)area inView:(UIView*)view;
@end
