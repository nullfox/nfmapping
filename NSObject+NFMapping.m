//
//  NSObject+NFMapping.m
//  Bandstalk
//
//  Created by Ben Fox on 7/13/13.
//  Copyright (c) 2013 Bandstalk. All rights reserved.
//

#import "NSObject+NFMapping.h"

@implementation NSObject (NFMapping)

- (id)initWithProperties:(NSDictionary *)properties attributeMapping:(NFMapping *)mapping
{
    if(!(self = [self init])) { return nil; }
    
    [[mapping attributes] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self setValue:[properties valueForKeyPath:key] forKey:obj];
    }];
    
    [[mapping transforms] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NFMappingTransformer block = obj;
        
        [self setValue:block(properties) forKeyPath:key];
    }];
    
    return self;
}

@end

@interface NFMapping ()

- (void)setAttributes:(NSDictionary *)attributes;

@end

@implementation NFMapping

+ (NFMapping *)mappingWithAttributes:(NSDictionary *)attributes
{
    NFMapping *mapping = [[[self class] alloc] init];
    
    [mapping setAttributes:attributes];
    
    return mapping;
}

- (void)setAttributes:(NSDictionary *)attributes
{
    _attributes = attributes;
}

- (void)addTransformAttributeTo:(NSString *)to transform:(NFMappingTransformer)transformer
{
    if(![self transforms]) {
        _transforms = [NSMutableDictionary dictionary];
    }
    
    [(NSMutableDictionary *)[self transforms] setObject:[transformer copy] forKey:to];
}

@end