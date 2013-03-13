//
//  ParallelExecutor.m
//  danmitsutype
//
//  Created by yu kawase on 13/01/14.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import "ParallelExecutor.h"

@implementation ParallelExecutor

// Override
-(void) tryNext:(NSObject*)data{
    if([commandList count] == 0){
        [self onComplete:data];
        return;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for(int i=0,max=[commandList count];i<max;i++){
        NSObject<ICommand>* command = [commandList commandAtIndex:i];
        dispatch_async(queue, ^{
            [command execute:data];
        });
    }
}

// Override
-(void) onComplete:(NSObject<ICommand>*)command data:(NSObject *)data{
    current++;
    if(current >= total){
        [delegate onComplete:self data:data];
    }
}

@end
