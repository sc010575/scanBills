//
//  DACoreDataHandler.m
//  scanBills
//
//  Created by Suman Chatterjee on 05/05/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DACoreDataHandler.h"
#import <KCOrderedAccessorFix/NSManagedObjectModel+KCOrderedAccessorFix.h>
#import "StoreMaster.h"
#import "Bills.h"

@implementation DACoreDataHandler

+ (void)setupCoreData
{
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"scanBills.sqlite"];
    [[NSManagedObjectModel MR_defaultManagedObjectModel] kc_generateOrderedSetAccessors];  //This line fixes bugs that occur adding objects to an ordered relationship
    
}

+ (BOOL)isCoreDataExits
{
    if (![StoreMaster MR_countOfEntities]) {
        //no records exits
        return NO;
    }
    return YES;
}


+(NSArray*) storeLists
{
    NSArray * storeList = [StoreMaster MR_findAllSortedBy:@"storeName" ascending:YES];
    return storeList;
    
}

+ (void)createNewStore:(NSString*)storeName andBill:(NSString*) billTitle description:(NSString*) description withImage:(NSData*) imageData
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        // Add new data
        long newStoreNumber = [DACoreDataHandler getBillNumberForStore:storeName] + 1;
        Bills * newBill = [Bills createInContext:localContext];
        newBill.billTitle = billTitle;
        newBill.billDescription =description;
        newBill.billDate = [NSDate date];
        newBill.billImage = imageData;
        newBill.billNumber = [NSNumber numberWithLong:newStoreNumber];
        
        StoreMaster * store = [StoreMaster createInContext:localContext];
        store.storeName = storeName;
        NSSet * billSet = [NSSet setWithObject:newBill];
        store.bills = billSet;
    }completion:^(BOOL success, NSError *error) {
        
        if (success) {
            
            NSLog(@"Store  created successfully");
            //            dispatch_async(dispatch_get_main_queue(), ^{
            //                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CATALOG_FINISHED_PARSING object:nil];
            //            });
        }
        
    }];
    
}

+ (long) getBillNumberForStore:(NSString*)storeName
{
    NSPredicate *storePredicate = [NSPredicate predicateWithFormat:@"storeName == %@", storeName];
    
    StoreMaster * store = [StoreMaster MR_findFirstWithPredicate:storePredicate];
    NSSet * bill = store.bills;
    long totalBillCount = bill.count;
    
    return totalBillCount;
}


@end
