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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Disable ARC in settings
    
    
    // Manual Reference Counting

    NSString *name = [[NSString alloc] initWithString:@"Paul"]; // retain: 1
    NSLog(@"Name: %@", name);

    NSString *alias = [name retain]; // retain: 2

    NSLog(@"Alias: %@", alias);

    [alias release]; // retain: 1
    alias = nil;    // don't accidentally use it again

    [name release]; // retain: 0 (memory is freed, and another object can use it)
    name = nil; // prevents you from accidentally using an object that has been cleaned up

    // Undefined behavior when using a pointer that has been cleaned up
    //    [name length];
    
    NSArray *array = [NSArray arrayWithObjects:@1, @2, @3, nil]; // autorelease
    NSLog(@"Array: %@", array);
    
    // establish ownership
    [array retain]; // retain: 1
    
    // cleanup (dealloc)
    [array release];
    
    
    NSString *path = @"/path/to/resource.txt";
    NSString *subpath = [path stringByDeletingLastPathComponent]; // autorelease
    NSLog(@"subpath: %@", subpath);


    Car *honda = [[Car alloc] initWithMake:@"Civic"];  // car: 1
    Person *person = [[Person alloc] initWithCar:honda]; // person: 1, car: 2
    [honda release]; // transfering ownership // car: 1
    honda = nil;

    // Hand off ownership
    // 1. releasing after passing data
    // 2. use autorelease object
    
    // use autorelease
//    Car *hummer = [[[Car alloc] initWithMake: @"H2"] autorelease];
//    person.car = hummer;
  
    // release after setting
    Car *hummer = [[Car alloc] initWithMake: @"H2"]; // hummer: +1 = 1
    person.car = hummer;    // hummer: +1 = 2
    [hummer release]; // hummer: -1 = 1
    
    // Potential problem with self assignment
    person.car = hummer;
    hummer = nil; // prevent a dangling pointer (NSZombie)

    // How do I clean up the memory?
    [person release]; // hummer: 0
    
    // Do I have a memory leak?
    
    
    
    // Is the object autoreleased? Why?

    NSString *name2 = [NSString stringWithFormat:@"%@ %@", @"John", @"Miller"];
    // yes
    
    NSDate *today = [NSDate date];
    // yes
    
    NSDate *now = [NSDate new];
    // no
    
    NSDate *tomorrow2 = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    // yes
    
    NSDate *nextTomorrow = [tomorrow2 copy];
    // no
    
    NSArray *words = [@"This sentence is the bomb" componentsSeparatedByString:@" "];
    // yes
    
    NSString *idea = [[NSString alloc] initWithString:@"Hello Ideas"];
    // no
    
    Car *blueCar = [[Car alloc] initWithMake:@"Forester"]; // retain: 1
    Car *redCar = [Car carWithMake:@"Forester"]; // autorelease
    // yes
    
    NSString *idea2 = [[[NSString alloc] initWithString:@"Hello Ideas"] autorelease];
    // yes
    
    NSString *idea3 = [[NSString alloc] initWithString:@"Hello Ideas"];
    // no
    [idea3 autorelease];
    // yes
    
}


@end
