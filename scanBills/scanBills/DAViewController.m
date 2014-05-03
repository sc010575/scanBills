//
//  DAViewController.m
//  scanBills
//
//  Created by Suman Chatterjee on 03/05/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DAViewController.h"

@interface DALaunchVC ()

@end

@implementation DALaunchVC

#pragma mark - view controller methods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
