//
//  Person.m
//  iOS9-MemoryManagement
//
//  Created by Paul Solt on 11/13/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "Person.h"
#import "Car.h"
#import "LSILog.h"

@implementation Person

- (instancetype)initWithCar:(Car *)car {
    self = [super init];
    if (self) {
        // Maintain ownership
        _car = [car retain];
        NSLog(@"-[Person init]: %@", _car);
    }
    return self;
}

- (void)dealloc {
    // TODO: Implement dealloc with MRC (order is important)
    NSLog(@"-[Person dealloc]: %@", _car);
    [_car release];
    _car = nil;
    
    [super dealloc];
}

// TODO: Implement setCar with MRC
- (void)setCar:(Car *)car {
    [_car release];         // -1 retain on previous value (if it existed)
    _car = [car retain];    // +1 retain
}

@end
