//
//  CommandList.m
//  danmitsutype
//
//  Created by yu kawase on 13/01/14.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import "CommandList.h"

@implementation CommandList

-(id) init{
    self = [super init];
    if(self){
        [self initialize];
    }
    
    return self;
}

-(void) initialize{
    list = [[NSMutableArray alloc] init];
}

// ▼ public =================================

-(int) count{
    return [list count];
}

-(void) push:(NSObject<ICommand>*)command{
    [list addObject:command];
}

-(NSObject<ICommand>*) commandAtIndex:(int)index{
    NSObject<ICommand>* command = [list objectAtIndex:index];
    
    // TODO error
    
    return command;
}

@end
