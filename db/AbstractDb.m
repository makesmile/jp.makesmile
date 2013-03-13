//
//  AbstractDb.m
//  kaimono
//
//  Created by yu kawase on 13/01/03.
//  Copyright (c) 2013年 kaimono. All rights reserved.
//

#import "AbstractDb.h"

@implementation AbstractDb

static FMDatabase* db;

+(void) create:(NSString*)dbName{
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    
    // コピー先
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:dbName];
    
    BOOL result_flag = [fm fileExistsAtPath:writableDBPath];
    if(!result_flag){
        // dbが存在してなかったらここが呼ばれて、作成したDBをコピー
        // コピー元
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
        BOOL copy_result_flag = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if(!copy_result_flag){
            //失敗したらここ
            NSLog(@"failure copy");
        }
    }
    
    db = [FMDatabase databaseWithPath:writableDBPath];
    [self initialize];
}

+(BOOL) hasError{
    FMDatabase* db = [self getDb];
    return ([db lastErrorCode] != 0);
}

+(void) showError{
    FMDatabase* db = [self getDb];
    NSLog(@"Error %@ - %d", [db lastErrorMessage], [db lastErrorCode]);
}

// abstract 
+(void) initialize{}

+(FMDatabase*)getDb{
    return db;
}

@end
