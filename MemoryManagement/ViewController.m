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

@interface ViewController () {
    // private ivar
}

// Private Property
@property (nonatomic, retain) NSString *name;

//- (void)setName:(NSString *)name {
//    _name = [name retain];
//}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Disable ARC in settings
    
    NSLog(@"Hi");
    
//    NSString *test = @"string literal"; // special allocation in readonly memory
    
    // alloc/init == retain
    // retainCount = 1
    // retain -> retainCount = 2
    // release -> retainCount = 1
    // release -> retainCount = 0 (Memory is destoyed ... i.e.: recycled for reuse)
    
    // dynamically allocating the string using alloc/init
    NSString *name = [[NSString alloc] initWithString:@"Paul"]; // name: 1
    
    // Pass by reference (means pass the variables memory address so we can both change the data)
    // Pass by reference - refering to something that already exists
    // Pass by value - CGRect
    self.name = name; // name: 2, self.name: 2 (both pointing to the same data)
    
//    - (void)setName:(NSString *)name {
//        _name = [name retain]; // name: 2  // assigning to our ivar in our property setter
//    }
    
    // retain/release are only available with ARC disabled (MRC - manual reference counting)
    [name retain]; // name: 3
    [name retain]; // name: 4
    
    // What will happen with name?
    
    // If I don't release name (down to zero retain count), we have a memory leak
    // no other in-memory app can use this location
    
    [name release]; // name: 3
    [name release]; // name: 2
    [name release]; // name: 1  // what happens now?

    name = nil; // Protecting your future self, because right now when we wrote this we knew the object was
    // finished and could be cleaned up ... so we prevent bugs with dangling pointers to deallocated memory
    // by setting to nil
    
    // Common Bug in Objective-C is to use the object or pointer reference after it has been recycled or cleaned up
    
    NSString *favoriteColor = [[NSString alloc] initWithString:@"Blue"];
    
    // Don't use a dangling pointer after you've released an object to 0
    NSLog(@"My name is %@", name); // Unpredictable behavior (delay in time could allow system to reuse this memory)
    [favoriteColor release];
    favoriteColor = nil; // protect my future self from misusing this dangling pointer (now it's nil)
    
    
} // end of scope, we lose the name reference

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateViews];
}

- (void)dealloc {
    [_name release];
    
    // Only in MRC do you call super dealloc
    [super dealloc];
}


- (void)updateViews {
    // name doesn't exist here, out of scope, because we don't have a property or instance variable
    //name // Error: Use of undeclared identifier 'name'
    
    //self.name // self.name: 1
    //_name     // _name: 1
    
    NSLog(@"My name is still: %@", self.name);
}

@end
