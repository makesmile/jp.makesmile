//
//  Command.m
//  com.aloe-project.learn1
//
//  Created by shimoigi on 12/09/02.
//  Copyright (c) 2012年 webMaterial. All rights reserved.
//

#import "Command.h"


@implementation Command

-(void)setCallback:(dispatch_block_t)callbackBlock_{
    callbackBlock = callbackBlock_;
}

-(void)execute:(NSObject*)data{
    // キューの指定がなければ作る
    if(queue == nil)
        queue = dispatch_queue_create("commandQueue", 0);
    [self internalExecute:data];
}

//-(void)childExecute:(dispatch_queue_t)queue_{
//    queue = queue_;
//    [self execute];
//}

//-(void)execute:(dispatch_queue_t)queue_{
//    queue = queue_;
//     isRoot = YES;
//    [self execute];
//}

// 子クラスで上書く
-(void)internalExecute:(NSObject*)data{
    [NSException raise:@"call abstract method" format:@"override internalExecute method"];
}

-(void)complete{
    if(callbackBlock != nil)
        dispatch_async(queue, callbackBlock);
}

-(void) internalComplete{
    [self complete];
    if(isRoot){
//        dispatch_release(queue);
    }
}

@end
