//
//  Executor.h
//  com.aloe-project.learn1
//
//  Created by shimoigi on 12/09/02.
//  Copyright (c) 2012年 webMaterial. All rights reserved.
//

#import "Command.h"

/**
 * コマンド実行ようのexecutor
 */
@interface Executor : Command{
    NSMutableArray* commands;
}

-(id)initWithCommands:(NSMutableArray*)commands_;
-(void)setCommands:(NSMutableArray*)commands_;
-(void)push:(Command*)command;

@end
