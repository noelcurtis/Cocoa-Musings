//
//  SECreateUser.m
//  SomeExamples
//
//  Created by Noel Curtis on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SECreateUser.h"
#import "SEUser.h"

@interface SECreateUser ()
@end

@implementation SECreateUser

@synthesize createdUserDelegate = _createdUserDelegate;

-(void)createUser{
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(actualCreateUser) userInfo:nil repeats:YES];
}

-(void)actualCreateUser{
    [_createdUserDelegate userCreated:[[[SEUser alloc] init] autorelease]];
}

@end
