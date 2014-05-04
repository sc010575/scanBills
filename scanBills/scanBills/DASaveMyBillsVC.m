//
//  DASaveMyBillsVC.m
//  scanBills
//
//  Created by Suman Chatterjee on 03/05/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DASaveMyBillsVC.h"

@interface DASaveMyBillsVC ()
@property (weak, nonatomic) IBOutlet UITextField *storeName;
@property (weak, nonatomic) IBOutlet UITextField *billTitle;
@property (weak, nonatomic) IBOutlet UITextField *description;
@property (weak, nonatomic) IBOutlet UIButton *svaveBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIImageView *storeImage;

- (IBAction)onSaveAction:(id)sender;
- (IBAction)onCancelAction:(id)sender;

@end

@implementation DASaveMyBillsVC

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
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.storeImage.image = self.imageToDisplay;
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

- (IBAction)onSaveAction:(id)sender {
}

- (IBAction)onCancelAction:(id)sender {
    [self performSegueWithIdentifier:@"goBackCamera" sender:sender];
}
@end
