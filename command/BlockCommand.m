//
//  BlockCommand.m
//  danmitsutype
//
//  Created by yu kawase on 13/01/14.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import "BlockCommand.h"

@implementation BlockCommand

-(id) initWithBlock:(commandBlock_t)block_{
    self = [super init];
    if(self){
        block = block_;
        [self initialize];
    }
    
    return self;
}

-(void) initialize{
    
}

// Override
-(void) internalExecute:(NSObject*)data{
    block(data);
    [self onComplete:data];
}

@end
