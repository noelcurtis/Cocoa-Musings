//
//  SEUrlDownloader.m
//  SomeExamples
//
//  Created by Noel Curtis on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SEUrlDownloader.h"

@interface SEUrlDownloader ()
@property (nonatomic, assign) BOOL executing;
@property (nonatomic, assign) BOOL finished;
@property (nonatomic, retain) NSURLConnection *urlConnection;
@end

@implementation SEUrlDownloader

@synthesize data = _data;
@synthesize executing = _executing;
@synthesize finished = _finished;
@synthesize isCancelled = _isCancelled;
@synthesize urlConnection = _urlConnection;

-(id)initWithUrl:(NSURL *)url{
    if(!self){
        self = [super init];
        _url = [url copy];
    }
    return self;
}

-(NSURL *)url{
    return _url;
}


-(void)dealloc{
    [self.urlConnection release];
    [self.data  release];
    [super dealloc];
}

// This method is just for convenience. It cancels the URL connection if it
// still exists and finishes up the operation.
- (void)done
{
    if( self.urlConnection ) {
        [self.urlConnection cancel];
        [self.urlConnection release];
        self.urlConnection = nil;
    }
    
    // Alert anyone that we are finished
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    self.executing = NO;
    self.finished  = YES;
    [self didChangeValueForKey:@"isFinished"];
    [self didChangeValueForKey:@"isExecuting"];
}
-(void)canceled {
	// Code for being cancelled
    NSLog(@"Something went wrong!");
	
    [self done];
	
}


# pragma mark Overrides
-(BOOL)isConcurrent{
    return YES;
}

-(BOOL)isExecuting{
    return self.executing;
}


-(BOOL)isFinished{
    return self.finished;
}

-(void)start{
    
}

#pragma mark Delegate Methods for NSURLConnection

// The connection failed
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    // Check if the operation has been cancelled
    if([self isCancelled]) {
        [self canceled];
		return;
    }
	else {
		[_data release];
		_data = nil;
		[self done];
	}
}

// The connection received more data
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Check if the operation has been cancelled
    if([self isCancelled]) {
        [self canceled];
		return;
    }
    
    [_data appendData:data];
}

// Initial response
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Check if the operation has been cancelled
    if([self isCancelled]) {
        [self canceled];
		return;
    }
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger statusCode = [httpResponse statusCode];
    if( statusCode == 200 ) {
        NSUInteger contentSize = [httpResponse expectedContentLength] > 0 ? [httpResponse expectedContentLength] : 0;
        _data = [[NSMutableData alloc] initWithCapacity:contentSize];
    } else {
        NSString* statusError  = [NSString stringWithFormat:NSLocalizedString(@"HTTP Error: %ld", nil), statusCode];
//        NSDictionary* userInfo = [NSDictionary dictionaryWithObject:statusError forKey:NSLocalizedDescriptionKey];
        NSLog(@"%@", statusError);
        [self done];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Check if the operation has been cancelled
    if([self isCancelled]) {
        [self canceled];
		return;
    }
	else {
		[self done];
	}
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

@end
