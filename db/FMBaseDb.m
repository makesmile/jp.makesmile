//
//  FMBaseDb.m
//  cocosearch
//
//  Created by yu kawase on 13/02/02.
//  Copyright (c) 2013年 cocosearch. All rights reserved.
//

#import "FMBaseDb.h"

@implementation FMBaseDb

static FMDatabase* db;
static NSLock* dbLock;
static NSCondition* dbCond;

+(void) removeDbFile:(NSString*)dbName{
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray* cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cacheDir = [cachePaths objectAtIndex:0];
    NSString *writableDBPath = [cacheDir stringByAppendingPathComponent:dbName];
    
    if([fm fileExistsAtPath:writableDBPath]){
        NSLog(@"removeDbFile");
        [fm removeItemAtPath:writableDBPath error:&error];
        if(error != nil){
            NSLog(@"error:%@", error.description);
        }
    }
}

+(void) createFromSql:(NSString*)dbName{
    [self create:dbName formSql:YES];
}

+(void) create:(NSString *)dbName {
    [self create:dbName formSql:NO];
}

+(void) create:(NSString*)dbName formSql:(BOOL)fromSql{
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSArray* cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cacheDir = [cachePaths objectAtIndex:0];
    NSString *writableDBPath = [cacheDir stringByAppendingPathComponent:dbName];
    
    NSLog(@"create");
    // コピー
    BOOL result_flag = [fm fileExistsAtPath:writableDBPath];
    if(!result_flag){
        // コピーする
        if(!fromSql){
            NSLog(@"copy");
            // コピー元
            NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
            BOOL copy_result_flag = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
            if(!copy_result_flag){
                NSLog(@"failure copy");
                // TODO えらー
            }
            
            db = [FMDatabase databaseWithPath:writableDBPath];
        }
        // sql から
        else{
            db = [FMDatabase databaseWithPath:writableDBPath];
            [self createTable];
        }
    }else{
        db = [FMDatabase databaseWithPath:writableDBPath];
    }
    
    dbLock = [[NSLock alloc] init];
    dbCond = [[NSCondition alloc] init];
    NSLog(@"create dbLock:%@", dbLock);
    [self initialize];
}

+(BOOL) hasError{
    FMDatabase* db = [self getDb];
    [self showError];
    BOOL hasError = ([db lastErrorCode] != 0);
    if(hasError){
        [self showError];
    }
    return hasError;
}

+(void) showError{
    FMDatabase* db = [self getDb];
    if(([db lastErrorCode] == 0)) return;
    NSLog(@"Error %@ - %d", [db lastErrorMessage], [db lastErrorCode]);
}

// abstract
+(void) initialize{}

+(void) createTable{};


// public 
+(FMDatabase*)getDb{
    return db;
}

+(void) beginTransaction{
    [db beginTransaction];
}

+(void) commit{
    [db commit];
}

+(void) rollback{
    [db rollback];
}

+(void) open{
    [self lock];
    [db open];
}

+(void) close{
    [db close];
    [self unlock];
}

+(void) lock{
//    while(![dbLock tryLock]){
//        [NSThread sleepForTimeInterval:0.1];
//        NSLog(@"sleep");
//    }
    [dbLock lock];
//    NSLog(@"lock:%@", dbLock);
}

+(void) unlock{
//    NSLog(@"unlock:%@", dbLock);
    [dbLock unlock];
}


@end
