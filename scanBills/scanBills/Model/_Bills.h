// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Bills.h instead.

#import <CoreData/CoreData.h>


extern const struct BillsAttributes {
	__unsafe_unretained NSString *barCode;
	__unsafe_unretained NSString *billDate;
	__unsafe_unretained NSString *billDescription;
	__unsafe_unretained NSString *billImage;
	__unsafe_unretained NSString *billNumber;
	__unsafe_unretained NSString *billTitle;
} BillsAttributes;

extern const struct BillsRelationships {
	__unsafe_unretained NSString *store;
} BillsRelationships;

extern const struct BillsFetchedProperties {
} BillsFetchedProperties;

@class StoreMaster;








@interface BillsID : NSManagedObjectID {}
@end

@interface _Bills : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BillsID*)objectID;





@property (nonatomic, strong) NSString* barCode;



//- (BOOL)validateBarCode:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* billDate;



//- (BOOL)validateBillDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* billDescription;



//- (BOOL)validateBillDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* billImage;



//- (BOOL)validateBillImage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* billNumber;



@property int16_t billNumberValue;
- (int16_t)billNumberValue;
- (void)setBillNumberValue:(int16_t)value_;

//- (BOOL)validateBillNumber:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* billTitle;



//- (BOOL)validateBillTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) StoreMaster *store;

//- (BOOL)validateStore:(id*)value_ error:(NSError**)error_;





@end

@interface _Bills (CoreDataGeneratedAccessors)

@end

@interface _Bills (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveBarCode;
- (void)setPrimitiveBarCode:(NSString*)value;




- (NSDate*)primitiveBillDate;
- (void)setPrimitiveBillDate:(NSDate*)value;




- (NSString*)primitiveBillDescription;
- (void)setPrimitiveBillDescription:(NSString*)value;




- (NSData*)primitiveBillImage;
- (void)setPrimitiveBillImage:(NSData*)value;




- (NSNumber*)primitiveBillNumber;
- (void)setPrimitiveBillNumber:(NSNumber*)value;

- (int16_t)primitiveBillNumberValue;
- (void)setPrimitiveBillNumberValue:(int16_t)value_;




- (NSString*)primitiveBillTitle;
- (void)setPrimitiveBillTitle:(NSString*)value;





- (StoreMaster*)primitiveStore;
- (void)setPrimitiveStore:(StoreMaster*)value;


@end
