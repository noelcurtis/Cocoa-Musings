//
//  SECreateUser.h
//  SomeExamples
//
//  Created by Noel Curtis on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEUser.h"

@protocol SECreatedUserDelegate

- (void)userCreated:(SEUser*)user;

@end

@interface SECreateUser : NSObject

@property (nonatomic, assign) id<SECreatedUserDelegate> createdUserDelegate;

-(void) createUser;

@end
