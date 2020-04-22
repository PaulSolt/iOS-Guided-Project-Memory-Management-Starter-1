//
//  Person.h
//  iOS9-MemoryManagement
//
//  Created by Paul Solt on 11/13/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Car;

@interface Person : NSObject

// Establish ownership for the car

// assign*
// MRC: retain, copy: +1 retain count

@property (nonatomic, retain) Car *car; // +1 retain count

- (instancetype)initWithCar:(Car *)car; // +1 retain count

@end
