//
//  NSObject+NFMapping.h
//  Bandstalk
//
//  Created by Ben Fox on 7/13/13.
//  Copyright (c) 2013 Bandstalk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^NFMappingTransformer)(NSDictionary *attributes);

@class NFMapping;

@interface NSObject (NFMapping)

- (id)initWithProperties:(NSDictionary *)properties attributeMapping:(NFMapping *)mapping;

@end

@interface NFMapping : NSObject

@property (nonatomic, readonly) NSDictionary *attributes;
@property (nonatomic, readonly) NSDictionary *transforms;

+ (NFMapping *)mappingWithAttributes:(NSDictionary *)attributes;

- (void)addTransformAttributeTo:(NSString *)to transform:(NFMappingTransformer)transformer;

@end