//
//  FMDbManager.h
//  fanap
//
//  Created by yu kawase on 13/04/25.
//  Copyright (c) 2013年 coode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "Utils.h"

@interface FMDbManager : NSObject{
    // db
    FMDatabase* db;
    
    // params
    NSLock* dbLock;
}

-(void) createDb:(NSString*)dbName;
-(void) open;
-(void) close;
-(void) beginTransaction;
-(void) commit;
-(void) rollback;
-(BOOL) hasError;
-(void) showError;

// db openしてる前提
-(void) updateTable:(NSString*)tableName data:(NSDictionary*)data;


@end
