//
//  FileUploadCommand.h
//  fanap
//
//  Created by yu kawase on 13/04/17.
//  Copyright (c) 2013年 coode. All rights reserved.
//

#import "AbstractCommand.h"

// vender
// http://d.hatena.ne.jp/glass-_-onion/20120304/1330826940
#import "R9HTTPRequest.h"

typedef void (^onUploadProgress_t)(float progress);

@interface AbstractImageUploadCommand : AbstractCommand{
    UIImage* image;
    NSString* fileName;
    NSString* url;
    NSDictionary* keys;
    
    R9HTTPRequest *request;
    
    onUploadProgress_t onProgress;
}

@property (strong) onUploadProgress_t onProgress;

-(id) initWithFile:(UIImage*)image_ keys:(NSDictionary*)keys_ withName:(NSString*)fileName_ url:(NSString*)url_;
-(NSString*) ext;

@end
