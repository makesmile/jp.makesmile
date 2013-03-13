//
//  Executor.m
//  com.aloe-project.learn1
//
//  Created by shimoigi on 12/09/02.
//  Copyright (c) 2012年 webMaterial. All rights reserved.
//

#import "Executor.h"

@implementation Executor

-(id) init{
    self = [super init];
    if(self){
        commands = [[NSMutableArray alloc] init];
    }
    return self;
}

-(id)initWithCommands:(NSMutableArray*)commands_{
    self = [self init];
    if(self){
        [self setCommands:commands_];
    }
    
    return self;
}

-(void)setCommands:(NSMutableArray*)commands_{
    commands = commands_;
}

-(void)push:(Command*)command{
    [commands addObject:command];
}

@end
