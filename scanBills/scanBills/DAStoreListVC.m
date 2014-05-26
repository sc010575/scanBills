//
//  DAStoreListVC.m
//  scanBills
//
//  Created by Suman Chatterjee on 11/05/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DAStoreListVC.h"
#import "DACoreDataHandler.h"
#import "StoreMaster.h"
#import "DABillDetailVC.h"

@interface DAStoreListVC ()

@property (strong, nonatomic) NSArray * storeList;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addNewStore;
@end

@implementation DAStoreListVC

- (NSArray *)storeList
{
    // Lazy instantiation.
    if (_storeList) return _storeList;
    _storeList = [DACoreDataHandler storeLists];
    return _storeList;
}   // storeList



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Stores";
    self.tableView.delegate = self;
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void) viewWillDisappear:(BOOL)animated
{
    self.storeList = nil;
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.storeList.count == 0)?1:self.storeList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"TableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.tintColor = [UIColor redColor];
    }
    
    if(self.storeList.count == 0){
        cell.textLabel.text = @"No store created";
        cell.accessoryType = UITableViewCellAccessoryNone;

    }
    else{
        StoreMaster * store = self.storeList[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = store.storeName;
    }
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}





// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        StoreMaster *store = self.storeList[indexPath.row];
        [MagicalRecord saveUsingCurrentThreadContextWithBlockAndWait:^(NSManagedObjectContext *localContext) {
            [localContext deleteObject:store];
        }];
        self.storeList = [DACoreDataHandler storeLists];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    [tableView endUpdates];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"storeDetail" sender:self ];
}





/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if([segue.identifier isEqualToString:@"storeDetail" ])
         {
             NSIndexPath *path= [self.tableView indexPathForSelectedRow];
             DABillDetailVC * billdetailVc = [segue destinationViewController];
             billdetailVc.storeMaster = self.storeList[path.row];
         }
 }
 

@end
