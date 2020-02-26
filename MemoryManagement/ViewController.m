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

@property (nonatomic, copy) NSString *favoriteFood; // setter will retain (+1)

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Disable ARC in settings
    
    NSLog(@"Hi");
    
    NSString *name = [[NSString alloc] initWithString:@"Paul"];  // alloc/init => retain 1
    NSLog(@"name: %@", name);

    // Two functions for MRC (These don't work in ARC)
    // retain
    // release
    [name retain]; // retain: 2
    [name retain]; // retain: 3
    [name release]; // retain: 2
    [name release]; // retain: 1

    NSString *alias = [name retain]; // name: 2
    NSString *copy = [name copy];   // copy: 1

    [copy release]; // copy: 0 (memory is immediately cleaned up)
    copy = nil;

    [name release]; // name: 1
    name = nil;

    [alias release];// name: 0
    alias = nil;
    
    // Hold onto data beyond viewDidLoad
    self.favoriteFood = @"Tacos"; // favoriteFood: 1
    
    
    // Car + Person
    
    Car *car = [[Car alloc] initWithMake:@"Forester"];  // car: 1
    Person *person = [[Person alloc] initWithCar:car];  // person: 1, car: 2
    [car release]; // car: 1
    car = nil;
    
//    Car *car = [Car carWithMake:@"Forester"];  // car: (autoreleased)
//    Person *person = [[Person alloc] initWithCar:car];  // person: 1, car: 1
    
    
    NSLog(@"Person: %@", person);
    NSLog(@"Car: %@", car);
    
    Car *corolla = [Car carWithMake:@"Corolla"];
    NSLog(@"corolla: %@", corolla);
    
    
    [person release];
    person = nil;
    
//    [self.view release]; // BAD!

    
    // Is the object autoreleased? Why?

    NSString *name2 = [NSString stringWithFormat:@"%@ %@", @"John", @"Miller"];
    // yes
    NSDate *today = [NSDate date];
    // yes
    
    NSDate *now = [NSDate new];  // [[NSDate alloc] init];
    // no (class method, not going to autoreleased)
    
    NSDate *tomorrow2 = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    // yes
    
    NSDate *nextTomorrow = [[tomorrow2 copy] autorelease]; // retain: 1
    // no
    
    NSArray *words = [@"This sentence is the bomb" componentsSeparatedByString:@" "];
    // yes
    
    NSString *idea = [[NSString alloc] initWithString:@"Hello Ideas"];
    // no
    
    Car *redCar = [Car carWithMake:@"Civic"];
    // yes
    
    NSString *idea2 = [[[NSString alloc] initWithString:@"Hello Ideas"] autorelease];
    // yes
    
    NSString *idea3 = [[NSString alloc] initWithString:@"Hello Ideas"];
    // no
    
    [idea3 autorelease];
    // yes
    
    NSLog(@"Now: %@", now);
    [now release];
    now = nil;
    
    [idea release]; // idea: 0 -> immediate memory cleanup (no longer safe to use the variable)
    idea = nil;
    
    
    // Arrays (collections)
    
    NSArray *inputArray = @[@"Paul", @"Isaac", @"John", @"Jesse"];

    // Manual Reference Counting = MRC = ownership
    NSMutableArray *names = [[NSMutableArray alloc] init]; // names: 1

    for (int i = 0; i < inputArray.count; i++) {
        NSString *name = [[NSString alloc] initWithFormat:@"%@", inputArray[i]]; // name: 1
        
        [names addObject:name]; // name: 2   // All Collections will call retain on objects they manage
        [name release]; // name: 1
    }

    [names removeAllObjects]; // reduce retain count and remove all values
}

- (void)dealloc {
    NSLog(@"Cleanup: ViewController");
    
    [_favoriteFood release];
    _favoriteFood = nil;
    
//    [idea release];   // won't work here, we can't release a local variable from viewDidLoad
    
    
    // At end call [super dealloc]
    [super dealloc];        // MUST call in MRC, cannot call in ARC
}

@end
