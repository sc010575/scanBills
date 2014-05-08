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

+ (void)createNewStoreAndAddBill:(Bills*) bill
{
    
}

@end
