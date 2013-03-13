//
//  CommandList.h
//  danmitsutype
//
//  Created by yu kawase on 13/01/14.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICommand.h"

@interface CommandList : NSObject{
    NSMutableArray* list;
}

-(int) count;
-(void) push:(NSObject<ICommand>*)command;
-(NSObject<ICommand>*) commandAtIndex:(int)index;

@end
