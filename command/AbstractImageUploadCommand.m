//
//  FileUploadCommand.m
//  fanap
//
//  Created by yu kawase on 13/04/17.
//  Copyright (c) 2013年 coode. All rights reserved.
//

#import "AbstractImageUploadCommand.h"

@implementation AbstractImageUploadCommand

@synthesize onProgress;

-(id) initWithFile:(UIImage*)image_ keys:(NSDictionary*)keys_ withName:(NSString*)fileName_ url:(NSString*)url_{
    self = [super init];
    if(self){
        image = image_;
        keys = keys_;
        fileName = [NSString stringWithFormat:@"%@.%@",fileName_, [self ext]];
        url = url_;
    }
    
    return self;
}

-(void) internalExecute:(NSObject *)data{
    NSURL *URL = [NSURL URLWithString:url];
    request = [[R9HTTPRequest alloc] initWithURL:URL];
    [request setHTTPMethod:@"POST"];
    for (NSString* key in keys) {
        id value = [keys objectForKey:key];
        [request addBody:value forKey:key];
    }
    // create image
    NSData* imageData = [self createData];;
    // set image data
    [request setData:imageData withFileName:fileName andContentType:[self contentType] forKey:@"photo"];
    
    [request setCompletionHandler:^(NSHTTPURLResponse *responseHeader, NSString *responseString){
        [self onComplete:responseString];
    }];
    // Progress
    [request setUploadProgressHandler:^(float newProgress){
        if(onProgress)
            onProgress(newProgress);
    }];
    [request startRequest];
}


// abstract =======================

-(NSData*) createData{
    return nil; // error
}

-(NSString*) contentType{
    return nil;
}

-(NSString*) ext{
    return nil;
}

@end
