//
//  URLLoadCommand.h
//  rssapp
//
//  Created by yu kawase on 13/02/28.
//  Copyright (c) 2013年 rssapp. All rights reserved.
//

#import "AbstractCommand.h"
#import "URLLoadOperation.h"

@interface URLLoadCommand : AbstractCommand{
    URLLoadOperation* urlLoadOperation;
    
    onError_t onError;
    onProgress_t onProgress;
    onFinished_t onFinished;
    
    BOOL loading;
}

-(void) setOnError:(onError_t)onError_;
-(void) setOnProgress:(onProgress_t)onProgress_;
-(void) setOnFinished:(onFinished_t)onFinished_;

-(id) initWithUrl:(NSString*)url;

-(BOOL) isLoading;

@end
