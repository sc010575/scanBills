// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to StoreMaster.m instead.

#import "_StoreMaster.h"

const struct StoreMasterAttributes StoreMasterAttributes = {
	.storeName = @"storeName",
};

const struct StoreMasterRelationships StoreMasterRelationships = {
	.bills = @"bills",
};

const struct StoreMasterFetchedProperties StoreMasterFetchedProperties = {
};

@implementation StoreMasterID
@end

@implementation _StoreMaster

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"StoreMaster" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"StoreMaster";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"StoreMaster" inManagedObjectContext:moc_];
}

- (StoreMasterID*)objectID {
	return (StoreMasterID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic storeName;






@dynamic bills;

	
- (NSMutableSet*)billsSet {
	[self willAccessValueForKey:@"bills"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"bills"];
  
	[self didAccessValueForKey:@"bills"];
	return result;
}
	






@end
