//
//  SEUser.m
//  SomeExamples
//
//  Created by Noel Curtis on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SEUser.h"

@implementation SEUser

@synthesize name = _name;
@synthesize age  = _age;
@synthesize street = _street;
@synthesize isAwesome = _isAwesome;

- (void)dealloc
{
    [_name release];
    [_street release];
    [super dealloc];
}

@end
