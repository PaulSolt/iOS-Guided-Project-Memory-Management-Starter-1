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
    
    NSLog(@"Hi");
    
//    NSString *test = @"string literal"; // special allocation in readonly memory
    
    // alloc/init == retain
    // retainCount = 1
    // retain -> retainCount = 2
    // release -> retainCount = 1
    // release -> retainCount = 0 (Memory is destoyed ... i.e.: recycled for reuse)
    
    // dynamically allocating the string using alloc/init
    NSString *name = [[NSString alloc] initWithString:@""]; // name: 1
    
    // retain/release are only available with ARC disabled (MRC - manual reference counting)
    [name retain]; // name: 2
    [name retain]; // name: 3
    
    // What will happen with name?
    
    // If I don't release name (down to zero retain count), we have a memory leak
    // no other in-memory app can use this location
} // end of scope, we lose the name reference


- (void)updateViews {
    // name doesn't exist here, out of scope, because we don't have a property or instance variable
    //name // Error: Use of undeclared identifier 'name'
}

@end
