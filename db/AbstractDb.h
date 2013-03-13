//
//  AbstractDb.h
//  kaimono
//
//  Created by yu kawase on 13/01/03.
//  Copyright (c) 2013年 kaimono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface AbstractDb : NSObject

+(void) create:(NSString*)dbName;
+(FMDatabase*)getDb;
+(BOOL) hasError;
+(void) showError;

// abstract
+(void) initialize;


@end


