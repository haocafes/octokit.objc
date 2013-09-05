//
//  OCTTreeEntry.m
//  OctoKit
//
//  Created by Josh Abernathy on 9/5/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTTreeEntry.h"

@implementation OCTTreeEntry

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"SHA": @"sha",
		@"URL": @"url",
	}];
}

+ (NSValueTransformer *)URLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)typeJSONTransformer {
	NSDictionary *typeByName = @{
		@"blob": @(OCTTreeEntryTypeBlob),
		@"tree": @(OCTTreeEntryTypeTree),
	};

	return [MTLValueTransformer
		reversibleTransformerWithForwardBlock:^(NSString *typeName) {
			return typeByName[typeName];
		}
		reverseBlock:^(NSNumber *type) {
			return [typeByName allKeysForObject:type].lastObject;
		}];
}

#pragma mark NSObject

- (NSUInteger)hash {
	return self.URL.hash;
}

- (BOOL)isEqual:(OCTTreeEntry *)entry {
	if (self == entry) return YES;
	if (![entry isKindOfClass:self.class]) return NO;

	return [entry.URL isEqual:self.URL];
}

@end
