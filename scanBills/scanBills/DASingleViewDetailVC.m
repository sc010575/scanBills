//
//  DASingleViewDetailVC.m
//  scanBills
//
//  Created by Suman Chatterjee on 14/05/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DASingleViewDetailVC.h"

@interface DASingleViewDetailVC ()
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UILabel *scancode;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;

@property (weak, nonatomic) IBOutlet UILabel *billTitle;
@property (weak, nonatomic) IBOutlet UIToolbar *deleteBtn;
@end

@implementation DASingleViewDetailVC

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
    self.detailImageView.image = [UIImage imageWithData:self.selectedBill.billImage];
    self.description.text = self.selectedBill.billDescription;
    self.scancode.text = self.selectedBill.barCode;
    self.billTitle.text = self.selectedBill.billTitle;
    self.navigationController.toolbarHidden = NO; 
    
 ; //self.selectedBill.billTitle;
}

- (void) viewWillLayoutSubviews
{
    self.mainScroll.contentSize = CGSizeMake(320, 1000);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
