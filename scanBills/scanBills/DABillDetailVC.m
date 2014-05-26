//
//  DABillDetailVC.m
//  scanBills
//
//  Created by Suman Chatterjee on 11/05/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DABillDetailVC.h"
#import "Bills.h"
#import "DASingleViewDetailVC.h"
#import "DABillViewCell.h"

@interface DABillDetailVC ()

@property (strong, nonatomic) NSArray * billLists;

@end

@implementation DABillDetailVC
{
    long totalBillCount;
    BOOL readyToLoad;
    Bills * selectedBill;
}

-(void) populateBills
{
    dispatch_queue_t parsingQueue = dispatch_queue_create("com.da.bills", NULL);
    
    dispatch_async(parsingQueue, ^{
        _billLists = [self.storeMaster.bills allObjects];;
       if (_billLists.count == totalBillCount){
            dispatch_async(dispatch_get_main_queue(), ^{
                readyToLoad = YES;
                [self.collectionView reloadData];
             });

        }
    });

}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.storeMaster.storeName;
    totalBillCount = [self.storeMaster.bills count];
    readyToLoad = NO;
    [self populateBills];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return totalBillCount;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    DABillViewCell *cell = (DABillViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    if(readyToLoad){
        Bills * bill = self.billLists[indexPath.row];
        UIImageView *storeImageView = (UIImageView *)[cell viewWithTag:100];
        storeImageView.image = [UIImage imageWithData:bill.billImage];
        
    }
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame-2.png"]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame-selected.png"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectedBill = self.billLists[indexPath.row];
    [self performSegueWithIdentifier:@"billView" sender:self];
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"billView" ])
    {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];

        DASingleViewDetailVC * singleBill = [segue destinationViewController];
        singleBill.selectedBill =  self.billLists[indexPath.row];
    }
}


@end
