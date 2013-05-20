//
//  FMDbManager.m
//  fanap
//
//  Created by yu kawase on 13/04/25.
//  Copyright (c) 2013年 coode. All rights reserved.
//

#import "FMDbManager.h"

@implementation FMDbManager


-(id) init{
    self = [super init];
    if(self){
        [self initialize];
    }
    
    return self;
}

-(void) initialize{
    dbLock = [[NSLock alloc] init];
}

// abstract =================

-(void) firstCreate{
    
}

// 共通 =====================

-(BOOL) hasError{
    [self showError];
    BOOL hasError = ([db lastErrorCode] != 0);
    if(hasError){
        [self showError];
    }
    return hasError;
}

-(void) showError{
    if(([db lastErrorCode] == 0)) return;
    NSLog(@"Error %@ - %d", [db lastErrorMessage], [db lastErrorCode]);
}

-(void) beginTransaction{
    [db beginTransaction];
}

-(void) commit{
    
    [db commit];
}

-(void) rollback{
    [db rollback];
}

-(void) open{
    [self lock];
    [db open];
}

-(void) close{
    [db close];
    [self unlock];
}

-(void) lock{
    [dbLock lock];
}

-(void) unlock{
    [dbLock unlock];
}

-(NSString*) createInsertSql:(NSString*)tableName record:(NSDictionary*)record noColmuns:(NSArray*)noColumns{
    NSMutableString* ms = [NSMutableString string];
    [ms appendString:@"INSERT OR IGNORE INTO "];
    [ms appendString:tableName];
    [ms appendString:@" ("];
    NSArray* keyList = [record allKeys];
    // sort
    keyList = [keyList sortedArrayUsingComparator:^(id o1, id o2) {
        return [o1 compare:o2];
    }];
    // noColumns
    NSMutableArray* newKeyList = [[NSMutableArray alloc] init];
    for(NSString* key in keyList){
        if([self hasStringInArray:key array:noColumns]) continue;
        [newKeyList addObject:key];
    }
    keyList = newKeyList;
    
    NSString* keyString = [keyList componentsJoinedByString:@","];
    [ms appendString:keyString];
    [ms appendString:@") VALUES ("];
    
    NSMutableArray* placeArray = [[NSMutableArray alloc] init];
    for(NSString* key in keyList){
        if([self hasStringInArray:key array:noColumns]){
            continue;
        }
        [placeArray addObject:@"?"];
    }
    NSString* placeString = [placeArray componentsJoinedByString:@","];
    [ms appendString:placeString];
    [ms appendString:@")"];
    
    return ms;
}

-(BOOL) hasStringInArray:(NSString*)str array:(NSArray*)array{
    for(NSString* s in array){
        if([s isEqualToString:str])
            return YES;
    }
    
    return NO;
}

-(NSString*) createUpdateSql:(NSString*)tableName record:(NSDictionary*)record noColumns:(NSArray*)noColumns{
    NSMutableString* ms = [NSMutableString string];
    [ms appendString:@"UPDATE "];
    [ms appendString:tableName];
    [ms appendString:@" SET "];
    NSArray* keyList = [record allKeys];
    keyList = [keyList sortedArrayUsingComparator:^(id o1, id o2) {
        return [o1 compare:o2];
    }];
    NSMutableArray* placeArray = [[NSMutableArray alloc] init];
    for(NSString* key in keyList){
        if([key isEqualToString:@"id"]) continue;
        if([self hasStringInArray:key array:noColumns])
            continue;
        [placeArray addObject:[NSString stringWithFormat:@"%@ = ?", key]];
    }
    [ms appendString:[placeArray componentsJoinedByString:@","]];
    [ms appendString:@" WHERE id = ?"];
    
    return ms;
}

-(NSString*) createInsertSql:(NSString*)tableName record:(NSDictionary*)record{
    return [self createInsertSql:tableName record:record noColmuns:nil];
}

-(NSString*) createUpdateSql:(NSString*)tableName record:(NSDictionary*)record{
    return [self createUpdateSql:tableName record:record noColumns:nil];
}

-(NSString*) createDeleteSql:(NSString*)tableName record:(NSDictionary*)record{
    
}

-(NSArray*) sortDicArray:(NSArray*)source{
    if([source count] == 0) return source;
    
}

// public ===================

-(void) createDb:(NSString*)dbName{
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSArray* cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cacheDir = [cachePaths objectAtIndex:0];
    NSString *dbFilePath = [cacheDir stringByAppendingPathComponent:dbName];
    
    if([fm fileExistsAtPath:dbFilePath]){ // 作成済み
        db = [FMDatabase databaseWithPath:dbFilePath];
        return;
    }
    
    db = [FMDatabase databaseWithPath:dbFilePath];
    [self firstCreate];
}

-(void) updateTable:(NSString*)tableName data:(NSDictionary*)data noColumns:(NSArray*)noColumns{
    NSArray* created = [data objectForKey:@"created"];
    NSArray* updated = [data objectForKey:@"updated"];
    NSArray* deleted = [data objectForKey:@"deleted"];
    
    // create =========
    if([created count] != 0){
        NSString* sql = [self createInsertSql:tableName record:[created objectAtIndex:0] noColmuns:noColumns];
        NSArray* keyList = [[created objectAtIndex:0] allKeys];
        keyList = [keyList sortedArrayUsingComparator:^(id o1, id o2) {
            return [o1 compare:o2];
        }];
        for(int i=0,max=[created count];i<max;i++){
            NSDictionary* row = [created objectAtIndex:i];
            NSMutableArray* valueList = [[NSMutableArray alloc] init];
            for(int j=0,jMax=[keyList count];j<jMax;j++){
                NSString* key = [keyList objectAtIndex:j];
                if([self hasStringInArray:key array:noColumns]){
                    continue;
                }
                [valueList addObject:[row objectForKey:key]];
            }
            [db executeUpdate:sql withArgumentsInArray:valueList];
            if([self hasError]){
                return;
            }
            //            NSLog(@"on insert :%@", [row objectForKey:@"title"]);
        }
    }
    
    // update ============
    if([updated count] != 0){
        NSString* sql = [self createUpdateSql:tableName record:[updated objectAtIndex:0] noColumns:noColumns];
        NSArray* keyList = [[updated objectAtIndex:0] allKeys];
        keyList = [keyList sortedArrayUsingComparator:^(id o1, id o2) {
            return [o1 compare:o2];
        }];
        for(NSDictionary* row in updated){
            NSMutableArray* valueList = [[NSMutableArray alloc] init];
            for(NSString* key in keyList){
                if([key isEqualToString:@"id"]) continue;
                if([self hasStringInArray:key array:noColumns]) continue;
                [valueList addObject:[row objectForKey:key]];
            }
            [valueList addObject:[row objectForKey:@"id"]];
            [db executeUpdate:sql withArgumentsInArray:valueList];
            [self showError];
        }
    }
    
    // delete =============
    if([deleted count] != 0){
        NSString* sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE id = ?", tableName];
    }
}

-(void) updateTable:(NSString*)tableName data:(NSDictionary*)data{
    [self updateTable:tableName data:data noColumns:nil];
}

@end
