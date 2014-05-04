// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Bills.m instead.

#import "_Bills.h"

const struct BillsAttributes BillsAttributes = {
	.billDate = @"billDate",
	.billDescription = @"billDescription",
	.billImage = @"billImage",
	.billNumber = @"billNumber",
};

const struct BillsRelationships BillsRelationships = {
	.store = @"store",
};

const struct BillsFetchedProperties BillsFetchedProperties = {
};

@implementation BillsID
@end

@implementation _Bills

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Bills" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Bills";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Bills" inManagedObjectContext:moc_];
}

- (BillsID*)objectID {
	return (BillsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"billNumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"billNumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic billDate;






@dynamic billDescription;






@dynamic billImage;






@dynamic billNumber;



- (int16_t)billNumberValue {
	NSNumber *result = [self billNumber];
	return [result shortValue];
}

- (void)setBillNumberValue:(int16_t)value_ {
	[self setBillNumber:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveBillNumberValue {
	NSNumber *result = [self primitiveBillNumber];
	return [result shortValue];
}

- (void)setPrimitiveBillNumberValue:(int16_t)value_ {
	[self setPrimitiveBillNumber:[NSNumber numberWithShort:value_]];
}





@dynamic store;

	






@end
