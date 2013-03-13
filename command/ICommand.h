//
//  ICommand.h
//  danmitsutype
//
//  Created by yu kawase on 13/01/14.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "executor/IExecutor.h"

@protocol ICommand;

@protocol CommandDelegate

-(void) onComplete:(NSObject<ICommand>*)command data:(NSObject*)data;
-(void) onCancle:(NSObject<ICommand>*)command;
-(void) onError:(NSObject<ICommand>*)command error:(NSError*)error;

@end

@protocol ICommand <NSObject>

-(void) setDelegate:(NSObject<CommandDelegate>*)delegate_;
-(void) execute:(NSObject*)data;

@end
