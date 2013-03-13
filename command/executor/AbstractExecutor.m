//
//  AbstractExecutor.m
//  danmitsutype
//
//  Created by yu kawase on 13/01/14.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import "AbstractExecutor.h"

@implementation AbstractExecutor

-(id)init{
    self = [super init];
    if(self){
        [self initialize];
    }
    
    return self;
}

-(void) initialize{
    commandList = [[CommandList alloc] init];
}

-(void) internalExecute:(NSObject*)data{
    total = [commandList count];
    current = 0;
    [self assignDelegate];
    [self tryNext:data];
}

-(void) assignDelegate{
    for(int i=0,max=[commandList count];i<max;i++){
        NSObject<ICommand>* command = [commandList commandAtIndex:i];
        [command setDelegate:self];
    }
}

-(BOOL) hasNext{
    return (current >= total);
}

-(void) tryNext:(NSObject*) data{
    if([self hasNext]){
        [delegate onComplete:self data:data];
    }else{
        NSObject<ICommand>* command = [commandList commandAtIndex:current];
        current++;
        [command execute:data];
    }
}

// callback ===========================
 
-(void) onComplete:(NSObject<ICommand>*)command data:(NSObject *)data{
    [self tryNext:data];
//    [delegate onComplete:self];
}

-(void) onCancel:(NSObject<ICommand>*)command{
//    [delegate onCancle:self];
}

-(void) onError:(NSObject<ICommand>*)command error:(NSError*)error{
//    [delegate onError:self error:error];
}


// ▼ public -==========================

-(void) push:(NSObject<ICommand>*)command{
    [commandList push:command];
}

@end
