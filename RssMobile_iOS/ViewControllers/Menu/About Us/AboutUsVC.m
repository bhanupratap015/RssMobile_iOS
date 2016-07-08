//
//  AboutUsVC.m
//  RssMobile_iOS
//
//  Created by Bhanu Pratap on 07/07/16.
//  Copyright © 2016 Bhanu Pratap. All rights reserved.
//

#import "AboutUsVC.h"

@interface AboutUsVC ()

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Add Navigation view
    [self addNavBarWithTitle:@"About us" andMenuButton:nil andBackButton:@"back" onView:self.view tag:2];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
