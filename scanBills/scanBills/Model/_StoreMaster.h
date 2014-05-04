// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to StoreMaster.h instead.

#import <CoreData/CoreData.h>


extern const struct StoreMasterAttributes {
	__unsafe_unretained NSString *storeName;
} StoreMasterAttributes;

extern const struct StoreMasterRelationships {
	__unsafe_unretained NSString *bills;
} StoreMasterRelationships;

extern const struct StoreMasterFetchedProperties {
} StoreMasterFetchedProperties;

@class Bills;



@interface StoreMasterID : NSManagedObjectID {}
@end

@interface _StoreMaster : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (StoreMasterID*)objectID;





@property (nonatomic, strong) NSString* storeName;



//- (BOOL)validateStoreName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *bills;

- (NSMutableSet*)billsSet;





@end

@interface _StoreMaster (CoreDataGeneratedAccessors)

- (void)addBills:(NSSet*)value_;
- (void)removeBills:(NSSet*)value_;
- (void)addBillsObject:(Bills*)value_;
- (void)removeBillsObject:(Bills*)value_;

@end

@interface _StoreMaster (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveStoreName;
- (void)setPrimitiveStoreName:(NSString*)value;





- (NSMutableSet*)primitiveBills;
- (void)setPrimitiveBills:(NSMutableSet*)value;


@end
