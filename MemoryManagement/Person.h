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

// TODO: Establish ownership for the car
// MRC: default will be assign, not retain
// retain, assign*
@property (nonatomic, retain) Car *car;

- (instancetype)initWithCar:(Car *)car;

@end
