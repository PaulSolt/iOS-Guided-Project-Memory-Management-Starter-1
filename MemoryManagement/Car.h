//
//  Car.h
//  MemoryManagement
//
//  Created by Paul Solt on 11/13/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

@property (nonatomic, copy) NSString *make;

- (instancetype)initWithMake:(NSString *)make;

// TODO: Create an autoreleased class method to create a Car

// How do you a create a class method?

// + = class method  (Class = blueprint for a building)
// - = instance method (Object = building #1 on 22nd street)

+ (instancetype)carWithMake:(NSString *)make;

@end
