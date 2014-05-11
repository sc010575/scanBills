//
//  DASaveMyBillsVC.m
//  scanBills
//
//  Created by Suman Chatterjee on 03/05/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DASaveMyBillsVC.h"
#import "DACoreDataHandler.h"
#import "Bills.h"

@interface DASaveMyBillsVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *storeName;
@property (weak, nonatomic) IBOutlet UITextField *billTitle;
@property (weak, nonatomic) IBOutlet UITextField *description;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
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
    [self.storeName becomeFirstResponder];
    self.saveBtn.enabled = NO;
    self.storeName.delegate = self;
    self.billTitle.delegate = self;
    self.description.delegate = self;
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
		[textField resignFirstResponder];
        return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([self.storeName.text length] != 0 || [self.billTitle.text length] != 0 )
        self.saveBtn.enabled = YES;
}


- (IBAction)onSaveAction:(id)sender {
    
    [self.storeName resignFirstResponder];
    [DACoreDataHandler createNewStore:self.storeName.text andBill:self.billTitle.text description:self.description.text withImage:UIImagePNGRepresentation(self.storeImage.image)];
}

- (IBAction)onCancelAction:(id)sender {
    [self performSegueWithIdentifier:@"goBackCamera" sender:sender];
}
@end
