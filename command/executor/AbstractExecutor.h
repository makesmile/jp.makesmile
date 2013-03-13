//
//  AbstractExecutor.h
//  danmitsutype
//
//  Created by yu kawase on 13/01/14.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IExecutor.h"
#import "CommandList.h"
#import "AbstractCommand.h"

@interface AbstractExecutor : AbstractCommand<IExecutor>{
    CommandList* commandList;
    int total;
    int current;
}

-(void) push:(NSObject<ICommand>*)command;


@end
