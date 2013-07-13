NSObject+NFMapping
=========

NFMapping is an NSObject category that aims to add simple, flexible property mapping from dictionaries of properties, nested or not.

Basic Usage
--------

```
#import <CoreLocation/CoreLocation.h>

#import "NSObject+NFMapping.h"

#import "Region.h"
#import "Country.h"

@interface City : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) Region *region;
@property (nonatomic, readonly) Country *country;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinates;

@end

NSDictionary *location = @{
  @"name": @"Petaluma",
  @"coordinates": @{
    @"latitude": 38.232417,
    @"longitude": -122.636652
  },
  @"state": @{
    @"abbr": @"CA",
    @"name": @"California"
  },
  @"country": @{
    @"iso2": @"US",
    @"name": @"United States"
  }
};

NFMapping *mapping = [NFMapping mappingWithAttributes:@{
  @"name": @"name"
}];

[mapping addTransformAttributeTo:@"coordinates" transform:^id(NSDictionary *attributes) {
  return CLLocationCoordinate2DMake([[attributes valueForKeyPath:@"coordinates.latitude"] floatValue], [[attributes valueForKeyPath:@"coordinates.longitude"] floatValue]);
}];

[mapping addTransformAttributeTo:@"region" transform:^id(NSDictionary *attributes) {
  return [[Region alloc] initWithProperties:[attributes objectForKey:@"state"] attributeMapping:[NFMapping mappingWithAttributes:.....]];
}];

[mapping addTransformAttributeTo:@"country" transform:^id(NSDictionary *attributes) {
  return [[Country alloc] initWithProperties:[attributes objectForKey:@"state"] attributeMapping:[NFMapping mappingWithAttributes:.....]];
}];

City *petaluma = [[City alloc] initWithProperties:location attributeMapping:mapping];
```
