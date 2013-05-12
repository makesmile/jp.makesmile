//
//  PostCommand.h
//  fanap
//
//  Created by yu kawase on 13/04/17.
//  Copyright (c) 2013年 coode. All rights reserved.
//

#import "AbstractCommand.h"

// vender
// http://d.hatena.ne.jp/glass-_-onion/20120304/1330826940
#import "R9HTTPRequest.h"

typedef void (^onErrorPost_t)(NSError* error);
typedef void (^onPostProgress_t)(float progress);

@interface PostCommand : AbstractCommand{
    NSString* url;
    NSDictionary* values;
    
    // callbacks
    onErrorPost_t onError;
    onPostProgress_t onProgress;
}

@property (strong) onErrorPost_t onError;
@property (strong) onPostProgress_t onProgress;

-(id) initWithValues:(NSDictionary*)values_ withUrl:(NSString*)url_;

@end
