//
//  StoryVC.m
//  RssMobile_iOS
//
//  Created by Bhanu Pratap on 07/07/16.
//  Copyright © 2016 Bhanu Pratap. All rights reserved.
//

#import "StoryVC.h"

@interface StoryVC ()

@end

@implementation StoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // Add Navigation view
    [self addNavBarWithTitle:@"Taal thok ke" andMenuButton:nil andBackButton:@"back" onView:self.view tag:2];

}



@end
