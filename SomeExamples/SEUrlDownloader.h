//
//  SEUrlDownloader.h
//  SomeExamples
//
//  Created by Noel Curtis on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SEUrlDownloader : NSOperation <NSURLConnectionDelegate>{
    NSURL *_url;
}

@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, readonly)  NSURL *url;
@property (nonatomic, assign) BOOL *isCancelled;

-(id)initWithUrl:(NSURL*) url;

@end
