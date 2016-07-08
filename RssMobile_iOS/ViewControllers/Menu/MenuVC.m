//
//  MenuVC.m
//  RssMobile_iOS
//
//  Created by Bhanu Pratap on 03/07/16.
//  Copyright © 2016 Bhanu Pratap. All rights reserved.
//

#import "MenuVC.h"

#import "UISidebarViewController.h"
#import "AppDelegate.h"

#import "AboutUsVC.h"


@interface MenuVC () <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, weak) IBOutlet UITableView * tblMenu;
@property (nonatomic, strong) NSArray * aryMenu;
@property (nonatomic, weak) IBOutlet UIView * bannerView;




@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.aryMenu = @[@"Home", @"My Shakha notes", @"Change Lamguage", @"Join RSS", @"Share app", @"About us", @"More apps"];
    
    UIView *view = [[UIView alloc] init];
    view.frame = self.bannerView.frame;
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor orangeColor] CGColor], (id)[[UIColor redColor] CGColor], nil];
    view.alpha = 0.5;
    [self.bannerView.layer insertSublayer:gradient atIndex:0];
    
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.aryMenu count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TABLE"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TABLE"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [self.aryMenu objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"home"];
    

    
    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];

    [self toggleSideBar];
  

    switch (indexPath.row) {
            
        case 2:
            [self changeLanguage];
            break;

            
        case 3:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.rss.org/pages/joinrss.aspx"]];
            break;

        case 4:
            [self share];
            break;

        case 5:
        {
            UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *aboutUs = [storyBoard instantiateViewControllerWithIdentifier:@"AboutUsVC"];
            self.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:aboutUs animated:YES completion:nil];
        }
            break;

        default:
            break;
    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 70;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - Share App
-(void)share{
    
    UIImage * image = [UIImage imageNamed:@"Menu.png"];
    NSArray *items = @[image];

    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
}


#pragma mark - Change Language 
-(void)changeLanguage{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Change Language" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"हिंदी" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        // हिंदी button tapped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"English" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // English button tapped.
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}






@end
