//
//  PostCommand.m
//  fanap
//
//  Created by yu kawase on 13/04/17.
//  Copyright (c) 2013年 coode. All rights reserved.
//

#import "PostCommand.h"

@implementation PostCommand

@synthesize onError;
@synthesize onProgress;

-(id) initWithValues:(NSDictionary*)values_ withUrl:(NSString*)url_{
    self = [super init];
    if(self){
        values = values_;
        url = url_;
    }
    
    return self;
}

-(void) internalExecute:(NSObject *)data{
    NSLog(@"PostCommand.internalExecute");
    NSURL *URL = [NSURL URLWithString:url];
    R9HTTPRequest *request = [[R9HTTPRequest alloc] initWithURL:URL];
    [request setHTTPMethod:@"POST"];
    for (NSString* key in values) {
        id value = [values objectForKey:key];
        [request addBody:value forKey:key];
    }
    [request setCompletionHandler:^(NSHTTPURLResponse *responseHeader, NSString *responseString){
        NSData *responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        [self onComplete:responseData];
    }];
    // Progress
    [request setUploadProgressHandler:^(float newProgress){
        NSLog(@"postCommand progress%f", newProgress);
        if(onProgress)
            onProgress(newProgress);
    }];
    // fail
    [request setFailedHandler:^(NSError *error){
        [self onError:error];
        if(onError)
            onError(error);
    }];
    [request startRequest];
}

@end
