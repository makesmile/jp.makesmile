//
//  IExecutor.h
//  danmitsutype
//
//  Created by yu kawase on 13/01/14.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICommand.h"

@protocol IExecutor <NSObject, CommandDelegate, ICommand>

@end
