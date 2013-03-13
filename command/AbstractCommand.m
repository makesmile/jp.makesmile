//
//  AbastractCommand.m
//  danmitsutype
//
//  Created by yu kawase on 13/01/14.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import "AbstractCommand.h"

@implementation AbstractCommand

-(void) setDelegate:(NSObject<CommandDelegate> *)delegate_{
    delegate = delegate_;
}

-(void) execute:(NSObject*)data{
    [self internalExecute:data];
}

// ▼ abstract ==========================

-(void) internalExecute:(NSObject*)data{}

// ▼ callback ===========================

-(void) onComplete:(NSObject*)data{
    [delegate onComplete:self data:data];
}

-(void) onCancel{
    [delegate onCancle:self];
}

-(void) onError:(NSError*)error{
    [delegate onError:self error:error];
}

@end
