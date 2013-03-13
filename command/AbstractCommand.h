//
//  AbastractCommand.h
//  danmitsutype
//
//  Created by yu kawase on 13/01/14.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICommand.h"

@interface AbstractCommand : NSObject<ICommand>{
    NSObject<CommandDelegate>* delegate;
}

// abstract =============
-(void) internalExecute:(NSObject*) data;
-(void) onComplete:(NSObject*)data;
-(void) onCancel;
-(void) onError:(NSError*)error;

@end
