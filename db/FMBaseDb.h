//
//  FMBaseDb.h
//  cocosearch
//
//  Created by yu kawase on 13/02/02.
//  Copyright (c) 2013年 cocosearch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface FMBaseDb : NSObject

+(void) removeDbFile:(NSString*)dbName;

+(void) createFromSql:(NSString*)dbName;
+(void) create:(NSString*)dbName;
+(FMDatabase*)getDb;
+(BOOL) hasError;
+(void) showError;
+(void) beginTransaction;
+(void) commit;
+(void) rollback;
+(void) open;
+(void) close;

+(void) lock;
+(void) unlock;

// abstract
+(void) initialize;
+(void) createTable;

@end
