//
//  SanghBooksVC.m
//  RssMobile_iOS
//
//  Created by Bhanu Pratap on 07/07/16.
//  Copyright © 2016 Bhanu Pratap. All rights reserved.
//

#import "SanghBooksVC.h"
#import "Constant.h"

#import "CollectionCell.h"

#define Cell_Indetifier @"SanghBookCell"

@interface SanghBooksVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic, strong)  NSArray * collectionArray;
@property (nonatomic, strong)  NSArray * collectionArrayImage;


@end

@implementation SanghBooksVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Add Navigation view
    [self addNavBarWithTitle:@"Sangh Books" andMenuButton:nil andBackButton:@"back" onView:self.view tag:2];

    
    // Do any additional setup after loading the view.    // Collection View Options
    self.collectionArray = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K (Khel)", @"L", @"M"];
    self.collectionArrayImage = [NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"search"],
                                 [UIImage imageNamed:@"search"],
                                 [UIImage imageNamed:@"search"],
                                 [UIImage imageNamed:@"search"],
                                 [UIImage imageNamed:@"search"],
                                 [UIImage imageNamed:@"search"],
                                 [UIImage imageNamed:@"search"],
                                 [UIImage imageNamed:@"search"],
                                 [UIImage imageNamed:@"search"],
                                 [UIImage imageNamed:@"videos"],
                                 [UIImage imageNamed:@"search"],
                                 [UIImage imageNamed:@"search"],
                                 [UIImage imageNamed:@"search"],

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
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Indetifier forIndexPath:indexPath];
    
    [cell.Title setText:[self.collectionArray objectAtIndex:indexPath.row]];
    [cell.image setImage:[self.collectionArrayImage objectAtIndex:indexPath.row]];
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    Alert(@"Under Development");
}

@end
