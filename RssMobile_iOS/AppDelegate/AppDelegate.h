//
//  AppDelegate.h
//  RssMobile_iOS
//
//  Created by Bhanu Pratap on 01/07/16.
//  Copyright © 2016 Bhanu Pratap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISidebarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UISidebarViewController *sidebarVC;


+ (AppDelegate *)delegate ;

@end

