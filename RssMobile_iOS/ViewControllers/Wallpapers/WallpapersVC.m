//
//  WallpapersVC.m
//  RssMobile_iOS
//
//  Created by Bhanu Pratap on 07/07/16.
//  Copyright © 2016 Bhanu Pratap. All rights reserved.
//

#import "WallpapersVC.h"

#import "Common.h"
#import "CollectionCell.h"

#define Cell_Indetifier_grid @"WallpaperGrid"
#define Cell_Indetifier_full @"WallpaperFull"


@interface WallpapersVC ()


@property (nonatomic, weak) IBOutlet UICollectionView * collectionViewGrid;
@property (nonatomic, weak) IBOutlet UICollectionView * collectionViewFull;


@property (nonatomic, strong) NSMutableArray * aryGrid;
@property (nonatomic, strong) NSMutableArray * aryFull;
@property (nonatomic, strong) NSMutableArray * aryImageGrid;
@property (nonatomic, strong) NSMutableArray * aryImageFull;






@end

@implementation WallpapersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Add Navigation view
    [self addNavBarWithTitle:@"Sangh Wallpapers" andMenuButton:nil andBackButton:@"back" onView:self.view tag:2];

    
    
    // Do any additional setup after loading the view.    // Collection View Options
    
    self.aryGrid = [[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K (Khel)", @"L", @"M", nil];
    
    self.aryImageGrid = [[NSMutableArray alloc] initWithObjects:
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

-(void)collectionViewFlowout{

    int space_cropped = 1;
    UICollectionViewFlowLayout *flow1 = [[UICollectionViewFlowLayout alloc] init];
    flow1.minimumInteritemSpacing = space_cropped;
    flow1.minimumLineSpacing = space_cropped;
    flow1.sectionInset = UIEdgeInsetsMake(0, 0, space_cropped,-2 );
    flow1.itemSize = CGSizeMake(width(self.view)/2-space_cropped,width(self.view)/2-space_cropped);
    [self.collectionViewGrid setCollectionViewLayout:flow1];
    
    int space_Full = 0;
    UICollectionViewFlowLayout *flow2 = [[UICollectionViewFlowLayout alloc] init];
    flow2.minimumInteritemSpacing = space_Full;
    flow2.minimumLineSpacing = space_Full;
    flow2.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow2.sectionInset = UIEdgeInsetsMake(space_Full, space_Full, space_Full,space_Full );
    flow2.itemSize = CGSizeMake(width(self.view), height(self.view));
    [self.collectionViewFull setCollectionViewLayout:flow2];

    [self SetCollectionViewFlowlayout];
}

#pragma mark - UICOLLECTION VIEW
#pragma mark  Set CollectionViewFlowlayout
-(void)SetCollectionViewFlowlayout
{
    if(self.aryGrid.count>2)
    {
        NSArray *originalArray = [NSArray arrayWithArray:self.aryGrid];
        id firstItem = originalArray[0];
        id lastItem = [originalArray lastObject];
        
        NSMutableArray *workingArray = [originalArray mutableCopy];
        [workingArray insertObject:lastItem atIndex:0];
        [workingArray addObject:firstItem];
        self.aryFull = [[NSMutableArray alloc] initWithArray:workingArray];

        
        NSArray *originalArrayImage = [NSArray arrayWithArray:self.aryImageGrid];
        id firstItemImg = originalArrayImage[0];
        id lastItemImg = [originalArrayImage lastObject];
        
        NSMutableArray *workingArrayImg = [originalArrayImage mutableCopy];
        [workingArrayImg insertObject:lastItemImg atIndex:0];
        [workingArrayImg addObject:firstItemImg];
        self.aryImageFull = [[NSMutableArray alloc] initWithArray:workingArrayImg];

    }
    else
    {
        self.aryFull = [[NSMutableArray alloc] initWithArray:self.aryGrid];
        self.aryImageFull = [[NSMutableArray alloc] initWithArray:self.aryImageFull];
    }
    
    [self.collectionViewGrid reloadData];
    self.collectionViewFull.hidden = YES;
    
}

#pragma mark -UICollectionView DataSource Methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView == self.collectionViewGrid)
        return self.aryGrid.count;
    else
        return self.aryFull.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == 1){
        CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Indetifier_grid forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.layer.masksToBounds = NO;
        
        [cell.image setImage:[self.aryImageGrid objectAtIndex:indexPath.row]];
        
        return cell;
    }
    else if(collectionView.tag == 2){
        
        CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Indetifier_full forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.layer.masksToBounds = NO;
        
        [cell.image setImage:[self.aryImageFull objectAtIndex:indexPath.row]];
        
        return cell;
    }
    return nil;
}


#pragma mark -UICollectionView Delegate Methods
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    self.collectionViewFull.hidden = NO;
    //            [self.btnCrossFullImage setHidden:NO];
    self.collectionViewFull.alpha = 0;
    //            self.btnCrossFullImage.alpha = 0;
    
    
    [UIView animateWithDuration:.7 animations:^{
        self.collectionViewFull.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    
//    [self.collectionViewFull reloadData];
    
//    
//    if(self.aryGrid.count>2)
//        [self.collectionViewFull setContentOffset:CGPointMake(_collectionViewFull.frame.size.width*(indexPath.row+1), 0)];
//    else
//        [self.collectionViewFull setContentOffset:CGPointMake(_collectionViewFull.frame.size.width*indexPath.row, 0)];
}

@end
