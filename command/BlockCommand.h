//
//  BlockCommand.h
//  danmitsutype
//
//  Created by yu kawase on 13/01/14.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import "AbstractCommand.h"

typedef void (^commandBlock_t)(NSObject* data);

@interface BlockCommand : AbstractCommand{
    commandBlock_t block;
}

-(id) initWithBlock:(commandBlock_t)block_;

@end
