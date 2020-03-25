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

- (instancetype)initWithCar:(Car *)car
{
    self = [super init];
    if (self) {
        // Implement initWithCar with MRC
        _car = [car retain]; // retain: +1
        NSLog(@"-[Person init]: %@", _car);
    }
    return self;
}

- (void)dealloc
{
    // Implement dealloc with MRC (order is important)
    NSLog(@"-[Person dealloc]: %@", _car);
    [_car release]; // retain: -1
    [super dealloc];
}

// Implement setCar with MRC
- (void)setCar:(Car *)car
{
    if (_car != car) {
        [_car release]; // release the honda civic
        
        //    [car retain];
        _car = [car retain]; // hold onto the hummer
    }
}

@end
