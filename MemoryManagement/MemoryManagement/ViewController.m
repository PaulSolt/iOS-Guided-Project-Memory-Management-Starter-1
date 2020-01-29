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

@property (nonatomic, retain) NSMutableArray *people;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Disable ARC in settings

    NSLog(@"Hi");

    NSString *jsonString = [[NSString alloc] initWithString:@"{ \"name\" : \"Paul\" }"]; // RetainCount = 1
    NSLog(@"jsonString: %p", jsonString);

    NSString *alias = [jsonString retain]; // RetainCount = 2
    NSLog(@"alias: %p", alias);

    [alias release]; // RetainCount = 1
    alias = nil;     // Clear out variable so we don't accidentally use it

    NSLog(@"Json: %@", jsonString);

    // Cleanup the memory
    [jsonString release]; // RetainCount = 0 (Immediately clean up the memory)
    jsonString = nil;
    
    
    // Collections are going to take ownership of the data we give them

    NSString *jim = [[NSString alloc] initWithString:@"Jim"];  // jim: 1

    // Typically we'll create our arrays using ivar in init method
    _people = [[NSMutableArray alloc] init]; // people: 1

    [self.people addObject:jim]; // jim: 2, people: 1 (array calls retain on the object we pass it)
    [jim release];  // jim: 1 transfering ownership to the collection
    
//    [self.people removeObject:jim]; // jim: 1 (array calls release when removing an object)
    

    Car *honda = [Car carWithMake:@"Civic"];
//    Car *honda = [[Car alloc] initWithMake:@"Civic"]; // honda: 1
    Person *sarah = [[Person alloc] initWithCar:honda]; // honda: 2, sarah: 1
//    [honda release]; // honda: 1, Transfering ownership


//    sarah.car = honda; // Potential crash if not set correctly
    
    
    
    [sarah release]; // sarah: 0, honda: 0
    
    NSString *name = [NSString stringWithFormat:@"%@ %@", @"John", @"Miller"];
    // Autoreleased? or not (YES, no it's not)
    // YES
    
    NSDate *today = [NSDate date];
    // YES
    
    NSDate *now = [NSDate new];
    // NO
    
    NSDate *tomorrow2 = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    // YES
    
    NSDate *nextTomorrow = [tomorrow2 copy]; // retain: 1
    // NO
    
    NSArray *words = [@"This sentence is the bomb" componentsSeparatedByString:@" "];
    // YES
    
    NSString *idea = [[NSString alloc] initWithString:@"Hello Ideas"];
    // NO (rule 3)
    
    Car *redCar = [Car carWithMake:@"Civic"];
    // YES
    
    NSString *idea2 = [[[NSString alloc] initWithString:@"Hello Ideas"] autorelease];
    // YES
    
    NSString *idea3 = [[NSString alloc] initWithString:@"Hello Ideas"];
    // NO
    [idea3 autorelease];
    // YES
    
    [now release];
    [nextTomorrow release];
    [idea release];
    
    
    
    
    
    
} // end of scope for the method

// Sample NSMutableArray addObject implementation
//- (void)addObject:(id)object {
//    [object retain]; // take ownership: incrementing the reference count
//    // insert into collection
//    [_internalArray addObject:object];
//}

- (void)dealloc {
    [_people release]; // Calls release on all objects inside // jim = 0, people = 0
    _people = nil;
    
    [super dealloc];
}

@end
