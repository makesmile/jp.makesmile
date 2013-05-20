//
//  URLLoadCommand.m
//  rssapp
//
//  Created by yu kawase on 13/02/28.
//  Copyright (c) 2013年 rssapp. All rights reserved.
//

#import "URLLoadCommand.h"

@implementation URLLoadCommand

-(id) initWithUrl:(NSString *)url{
    self = [super init];
    if(self){
        [self initialize:url];
    }
    
    return self;
}

-(void) initialize:(NSString*)url{
    loading = NO;
    urlLoadOperation = [[URLLoadOperation alloc] init];
    [urlLoadOperation setUrl:url];
    
    urlLoadOperation.onProgress = ^(URLLoadOperation* operation, float progress){
        if(onProgress != nil){
            onProgress(operation, progress);
        }
    };
    urlLoadOperation.onFinished = ^(URLLoadOperation* operation, NSData* data){
        if(onFinished != nil){
            onFinished(operation, data);
        }
        
        [self onComplete:data];
    };
    urlLoadOperation.onError = ^(URLLoadOperation* operation, NSError* error){
        NSLog(@"error:%@", error.debugDescription);
        if(onError){
            NSLog(@"exists onerror ");
            onError(operation, error);
        }
        
        [self onError:error];
    };
}

-(void) setOnError:(onError_t)onError_{
    onError = onError_;
    loading = NO;
}

-(void) setOnFinished:(onFinished_t)onFinished_{
    onFinished = onFinished_;
    loading = NO;
}

-(void) setOnProgress:(onProgress_t)onProgress_{
    onProgress = onProgress_;
}

-(BOOL) isLoading{
    return loading;
}

// Override
-(void) internalExecute:(NSData*)data{
    loading = YES;
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    
    // TODO priority
//    [urlLoadOperation setQueuePriority:NSOperationQueuePriorityVeryHigh];
    [queue addOperation:urlLoadOperation];
}

@end
