//
//  BaseViewController.m
//  RssMobile_iOS
//
//  Created by Bhanu Pratap on 03/07/16.
//  Copyright © 2016 Bhanu Pratap. All rights reserved.
//

#import "BaseViewController.h"
#import "Constant.h"
#import "Common.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sideBarController = [[UISidebarViewController alloc] init];
}


// Add Nav Bar
#pragma mark - Add Navigation Bar
-(void)addNavBarWithTitle:(NSString *)title  andMenuButton:(NSString *)menu andBackButton:(NSString *)Back onView:(UIView*)onView tag:(NSInteger )tag{
    
        if(tag == 1)
            _navBar=[[[NSBundle mainBundle] loadNibNamed:@"NavBar" owner:self options:nil] lastObject];
        else
            _navBar=[[[NSBundle mainBundle] loadNibNamed:@"NavBar2" owner:self options:nil] lastObject];
        [_viewNavbar addSubview:_navBar];
        _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([menu isEqualToString:@"menu"]) {
        [_navBar.btnMenu addTarget:self action:@selector(goToMenu) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if ([Back isEqualToString:@"back"]) {
        [_navBar.btnBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    }

        [_navBar.lblTitle setText:title];

}


-(void)toggleSideBar{
    [[[AppDelegate delegate] sidebarVC] toggleSidebar:nil];
}

#pragma mark - Menu Option
-(void)goToMenu{
    [self toggleSideBar];
}

-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
