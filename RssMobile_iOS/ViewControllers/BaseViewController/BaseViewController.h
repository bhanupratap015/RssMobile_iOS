//
//  BaseViewController.h
//  RssMobile_iOS
//
//  Created by Bhanu Pratap on 03/07/16.
//  Copyright © 2016 Bhanu Pratap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavBar.h"
#import "AppDelegate.h"
#import "UISidebarViewController.h"

@interface BaseViewController : UIViewController

-(void)addNavBarWithTitle:(NSString *)title  andMenuButton:(NSString *)menu andBackButton:(NSString *)Back onView:(UIView*)onView tag:(NSInteger )tag;

@property (strong, nonatomic) NavBar *navBar;
@property (strong,nonatomic)AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UIView *viewNavbar;



@property (nonatomic, strong) UISidebarViewController * sideBarController;


-(void)toggleSideBar;


@end
