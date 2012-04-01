//
//  SomeExamplesTests.m
//  SomeExamplesTests
//
//  Created by Noel Curtis on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SomeExamplesTests.h"

@interface SomeExamplesTests ()
@property (nonatomic, retain) SECreateUser *userFactory;
@end

@implementation SomeExamplesTests

@synthesize userFactory = _userFactory;

- (void)setUp
{
    [super setUp];
    _userFactory = [[SECreateUser alloc] init];
    [_userFactory setCreatedUserDelegate:self];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testUserGetsCreated
{
    [_userFactory createUser];
}


-(void)userCreated:(SEUser *)user{
    STAssertNotNil(user, @"User was not created correctly!");
}


@end
