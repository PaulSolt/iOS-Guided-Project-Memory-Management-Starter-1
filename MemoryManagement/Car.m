//
//  Car.m
//  iOS9-MemoryManagement
//
//  Created by Paul Solt on 11/13/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "Car.h"
#import "LSILog.h"

@implementation Car

- (instancetype)initWithMake:(NSString *)make
{
    self = [super init];
    if (self) {
        NSLog(@"-[Car init]: %@", make);
        _make = [make copy]; // make: +1
    }
    return self;
}

// TODO: Implement autoreleased class car method


- (void)dealloc {
    NSLog(@"-[Car dealloc]: %@", self);
    
    [_make release];
    _make = nil;
    
    [super dealloc];
}

- (NSString *)description
{
    // TODO: Implement a standard autoreleasing method.
    NSString *description = [NSString stringWithFormat:@"Car: %@", self.make]; // autoreleased object
//    NSString *description = [[[NSString alloc] initWithFormat:@"Car: %@", self.make] autorelease];

//    NSString *description = [[NSString alloc] initWithFormat:@"Car: %@", self.make]; // 1
//    [description release]; // 0 -> CRASH object is deallocated before it returns
    return description;
}

@end
