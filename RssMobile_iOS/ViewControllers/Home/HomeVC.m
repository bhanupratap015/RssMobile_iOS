//
//  HomeVC.m
//  RssMobile_iOS
//
//  Created by Bhanu Pratap on 03/07/16.
//  Copyright © 2016 Bhanu Pratap. All rights reserved.
//

#import "HomeVC.h"
#import "HomeViewCell.h"
#import "Constant.h"


#import "StoryVC.h"
#import "SanghBooksVC.h"
#import "WallpapersVC.h"

#define Cell_Indetifier @"HomeCell"


@interface HomeVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>



@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic, strong)  NSArray * collectionArray;
@property (nonatomic, strong)  NSArray * collectionArrayImage;



@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // Add Navigation view
    [self addNavBarWithTitle:@"Home" andMenuButton:@"menu" andBackButton:nil onView:self.view tag:1];

    // Collection View Options
    self.collectionArray = @[@"Panchang", @"Shakha Locator", @"New Reader", @"Quotes", @"Sangh Books", @"Wallpapers", @"Desbhakti Geet", @"Ghosh audio", @"Videos", @"Explore Rss", @"Sharirik (Khel)", @"Story"];
    self.collectionArrayImage = [NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"notice_board"],
                                 [UIImage imageNamed:@"shakha_locator"],
                                 [UIImage imageNamed:@"news_reader"],
                                 [UIImage imageNamed:@"quotes"],
                                 [UIImage imageNamed:@"book"],
                                 [UIImage imageNamed:@"wallpaper"],
                                 [UIImage imageNamed:@"songs"],
                                 [UIImage imageNamed:@"ghosh"],
                                 [UIImage imageNamed:@"videos"],
                                 [UIImage imageNamed:@"search"],
                                 [UIImage imageNamed:@"news_reader.png"],
                                 [UIImage imageNamed:@"story"],
                                 nil];
    
    [self collectionViewFlowout];
    
    
}


#pragma mark -UICollectionView DataSource Methods

-(void)collectionViewFlowout{
    
    UICollectionViewFlowLayout *flow1 = [[UICollectionViewFlowLayout alloc] init];
    flow1.minimumInteritemSpacing = 0;
    flow1.minimumLineSpacing = 0;
    flow1.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0 );
    flow1.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame)/3 , (CGRectGetWidth(self.view.frame)/2 )- 45);
    [self.collectionView setCollectionViewLayout:flow1];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Indetifier forIndexPath:indexPath];
    
    [cell.Title setText:[self.collectionArray objectAtIndex:indexPath.row]];
    [cell.image setImage:[self.collectionArrayImage objectAtIndex:indexPath.row]];
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];

    switch (indexPath.row) {

        case 4:
            [self goSanghBooksView];
            break;

        case 5:
            [self goWallpaperView];
            break;

            
        case 11:
            [self goStoryView];
            break;
            
        default:
            Alert(@"Under Development");
            break;
    }
    
    
}


#pragma mark -
#pragma mark  Go To Sangh Books Views

-(void)goSanghBooksView
{
    
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *aboutUs = [storyBoard instantiateViewControllerWithIdentifier:@"SanghBooksVC"];
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:aboutUs animated:YES completion:nil];

}

#pragma mark  Go To Story Views
-(void)goStoryView
{
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *aboutUs = [storyBoard instantiateViewControllerWithIdentifier:@"StoryVC"];
    self.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:aboutUs animated:YES completion:nil];
    
}


#pragma mark  Go To Sangh Wallpaper Views
-(void)goWallpaperView
{
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *aboutUs = [storyBoard instantiateViewControllerWithIdentifier:@"WallpapersVC"];
    self.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:aboutUs animated:YES completion:nil];
    
}

@end
