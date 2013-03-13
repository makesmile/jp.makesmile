//
//  UpdateOperation.h
//  cocosearch
//
//  Created by yu kawase on 12/12/12.
//  Copyright (c) 2012年 cocosearch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class URLLoadOperation;

typedef void (^onProgress_t)(URLLoadOperation* operation, float progress);
typedef void (^onFinished_t)(URLLoadOperation* operation, NSData* data);
typedef void (^onError_t)(URLLoadOperation* operation, NSError* error);

@protocol IURLLoadOperationDelegate <NSObject>

-(void)onProgress:(URLLoadOperation*)operation progress:(float)progress;
-(void)onFinished:(URLLoadOperation*)operation data:(NSData*)data;
-(void)onError:(URLLoadOperation*)operation  error:(NSError*)error;

@end

@interface URLLoadOperation : NSOperation<NSURLConnectionDataDelegate>{
    NSMutableURLRequest* urlRequest;
    BOOL isFinished;
    BOOL isExecuting;
    float totalBytes;
    float loadedBytes;
    
    // callback
    onProgress_t onProgress;
    onFinished_t onFinished;
    onError_t onError;
    
    NSObject<IURLLoadOperationDelegate>* callbackObject;
    NSString* url;
    NSMutableData* reseivedData;
}

@property (strong) onProgress_t onProgress;
@property (strong) onFinished_t onFinished;
@property (strong) onError_t onError;

-(id) initWithCallbackObject:(NSObject<IURLLoadOperationDelegate>*)callbackObject_ withUrl:(NSString*)url_;
-(void) setCallbackObject:(NSObject<IURLLoadOperationDelegate>*)callbackObject_;
-(void) setUrl:(NSString*)url_;
-(NSString*) getUrl;
-(NSString*) getId;

// protected
-(void) initialize;


@end
