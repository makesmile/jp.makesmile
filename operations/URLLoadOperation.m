//
//  UpdateOperation.m
//  cocosearch
//
//  Created by yu kawase on 12/12/12.
//  Copyright (c) 2012年 cocosearch. All rights reserved.
//

#import "URLLoadOperation.h"
#define TIME_OUT 20

@implementation URLLoadOperation

@synthesize onError;
@synthesize onProgress;
@synthesize onFinished;

// http://d.hatena.ne.jp/glass-_-onion/20110706/1309909082
// http://blog.cloud-study.com/?p=17


+ (BOOL)automaticallyNotifiesObserversForKey:(NSString*)key {
    if ([key isEqualToString:@"isExecuting"] ||
        [key isEqualToString:@"isFinished"]) {
        return YES;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

-(id) init{
    self = [super init];
    if(self){
        reseivedData = [[NSMutableData alloc] init];
        [self initialize];
    }
    
    return self;
}

// protected
-(void) initialize{}

-(id) initWithCallbackObject:(NSObject<IURLLoadOperationDelegate>*)callbackObject_ withUrl:(NSString*)url_{
    self = [self init];
    if(self){
        callbackObject = callbackObject_;
        url = url_;
    }
    
    return self;
}

-(void) setCallbackObject:(NSObject<IURLLoadOperationDelegate>*)callbackObject_{
    callbackObject = callbackObject_;
}

-(void) setUrl:(NSString*)url_{
    url = url_;
}

-(NSString*) getUrl{
    return url;
}

-(NSString*) getId{
    return @"";
}

-(void)start{
    urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [urlRequest setTimeoutInterval:TIME_OUT];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
    [self setValue:[NSNumber numberWithBool:YES] forKey:@"isExecuting"];
    [self setValue:[NSNumber numberWithBool:NO] forKey:@"isFinished"];
    while (![self isFinished] && ![self isCancelled]) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
}

// NSURLConnectionDataDelegate ==========================

- (NSURLRequest *)connection:(NSURLConnection *)connection
             willSendRequest:(NSURLRequest *)request
            redirectResponse:(NSURLResponse *)response{
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    totalBytes = [response expectedContentLength];
    loadedBytes = 0.0;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [reseivedData appendData:data];
    loadedBytes += [data length];
    float progress = loadedBytes/totalBytes;
    [callbackObject onProgress:self progress:progress];
    
    if(onProgress != nil)
        onProgress(self, progress);
}

- (void)connection:(NSURLConnection *)connection
   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse{
    return cachedResponse;
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self setValue:[NSNumber numberWithBool:NO] forKey:@"isExecuting"];
    [self setValue:[NSNumber numberWithBool:YES] forKey:@"isFinished"];
    [callbackObject onError:self error:error];
    NSLog(@"urlloader error ");
    if(onError != nil){
        NSLog(@"exists urlloader error ");
        onError(self, error);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self setValue:[NSNumber numberWithBool:NO] forKey:@"isExecuting"];
    [self setValue:[NSNumber numberWithBool:YES] forKey:@"isFinished"];
    [callbackObject onFinished:self data:reseivedData];
    
    if(onFinished != nil)
        onFinished(self, reseivedData);
}

// NSOperation =================================

//-(BOOL) isConcurrent{
//    return YES;
//}

-(BOOL) isExecuting{
    return isExecuting;
}
//
-(BOOL) isFinished{
    return isFinished;
}


@end
