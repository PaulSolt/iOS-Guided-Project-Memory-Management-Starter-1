//
//  ViewController.m
//  MemoryManagement
//
//  Created by Paul Solt on 1/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "Car.h"
#import "Person.h"
#import "LSILog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // TODO: Disable ARC (Automatic Reference Counting) in settings
    
    NSLog(@"Hi");
    
    
    // 4 bytes 4 characters
    
    // Referencing counting

    // alloc/init, new, copy, mutableCopy -> retain count of 1
    NSString *name = [[NSString alloc] initWithString:@"Paul"]; // Retain count: 1

    [name retain];  // +1 retain count: name: 2
    [name release]; // -1 retain count: name: 1
    [name release]; // -1 -> name: 0 -> Memory is cleaned up here
    
    // At this point it is unsafe to use name, since it points to deallocated memory
    // May work, may not work, depending on if the memory has already been reused by the system
    // NSLog(@"%@", [name stringByAppendingFormat:@"Hello"]);

    // unsafe to use name because the memory has been cleaned up and potentially reused
    name = nil; // prevents using a "dangling pointer" -> CRASH (if lucky) or Unpredictable behavior

    // Array (collection types)
    NSMutableArray *colors = [[NSMutableArray alloc] initWithObjects:
                              [[[NSString alloc] initWithString:@"Red"] autorelease],
                              nil]; // colors: 1, Red: 1
    
    NSString *blue = [[NSString alloc] initWithString:@"Blue"]; // blue: 1
    [colors addObject:blue]; // blue: 2 (adding elements to collections increments their retain count)
    [blue release]; // blue: 1 - transfer ownership to the array
    blue = nil;     // prevent me from using this pointer accidentally in the future
    // setting to nil protects our future self from logic errors
    
    [colors release]; // colors: 0, Red: 0, blue: 0
    colors = nil;
    
    
    // Car + Person -> ownership

    Car *civic = [[[Car alloc] initWithMake:@"Civic"] autorelease]; // civic: ~1
    Person *bob = [[Person alloc] initWithCar:civic]; // bob: 1, civic: 1
    // [civic release]; // other option to transfer ownership -> forget and it's a memory leak
    
    //bob.car = [[[Car alloc] initWithMake:@"Forester"] autorelease]; // forester: 1, civic: 0

    Car *forester = [[Car alloc] initWithMake:@"Forester"]; // 1
    bob.car = forester; // 2
    [forester release]; // 1

    bob.car = forester; // 1
    
    
    
    // Cleanup memory
    [bob release]; // bob: 0, forester: 0
    bob = nil;
    
    Car *accord = [Car carWithMake:@"accord"]; // autoreleased
} // end of scope (put things in properties to hold onto them, or release them before we get here)


@end
