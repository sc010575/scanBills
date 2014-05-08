//
//  DACoreDataHandler.h
//  scanBills
//
//  Created by Suman Chatterjee on 05/05/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Bills;
@interface DACoreDataHandler : NSObject

+ (void)setupCoreData;
+ (BOOL)isCoreDataExits;
+ (NSArray*)storeLists;
+ (void)createNewStoreAndAddBill:(Bills*) bill;
@end
