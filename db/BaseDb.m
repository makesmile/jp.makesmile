//
//  BaseDb.m
//  reedly
//
//  Created by yu kawase on 12/12/06.
//  Copyright (c) 2012年 reedly. All rights reserved.
//

#import "BaseDb.h"
#define DEFAULT_DB_FILE_NAME @"aloeApp.db"

@implementation BaseDb

static sqlite3 *database;
static NSString* dbFileName;
static NSLock* dbLock;

+(sqlite3*) getDatabase{
    return database;
}

+(void) create{
    if(database != NULL) return;
    if(dbFileName == nil){
        dbFileName = DEFAULT_DB_FILE_NAME;
    }

    NSArray* cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cacheDir = [cachePaths objectAtIndex:0];
    
    NSString* dbFilePath = [NSString stringWithFormat:@"%@/%@", cacheDir, dbFileName];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbFilePath]){
        NSError* error = nil;
        
		// 文書フォルダーに存在しない場合は、データベースの複製元をバンドルから取得します。
		NSString* assetDbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbFileName];
        
        NSLog(@"copy db");
        
		// バンドルから取得したデータベースファイルを文書フォルダーにコピーします。
		if (![fileManager copyItemAtPath:assetDbPath toPath:dbFilePath error:&error])
		{
			// データベースファイルのコピーに失敗した場合の処理です。
			NSLog(@"failure copy db %@", assetDbPath);
            NSLog(@"%@", error);
		}
    }else{
        //        NSLog(@"exits file: %@", dbFilePath);
    }
    
    if (sqlite3_open([dbFilePath UTF8String], &database) == SQLITE_OK){
        NSLog(@"open dbFile");
        dbLock = [[NSLock alloc] init];
    }else{
        NSLog(@"failure dbFile");
    }
}

+(void) createWithDbFileName:(NSString*)dbFileName_{
    dbFileName = dbFileName_;
    [self create];
}

+(void) lock{
    [dbLock lock];
}

+(void) unlock{
    [dbLock unlock];
}

+(void) beginTransaction{
    sqlite3_exec(database, "BEGIN TRANSACTION", NULL, NULL, NULL);
}

+(void) commit{
    sqlite3_exec(database, "COMMIT TRANSACTION", NULL, NULL, NULL);
}

+(void) rollback{
    sqlite3_exec(database, "ROLLBACK TRANSACTION", NULL, NULL, NULL);
}

+(BOOL) hasError{
    return (sqlite3_errcode(database) != 0);
}

+(void) showErrorMessage{
    if([self hasError]){
        NSLog( @"Failed errorCode:%d, errorMessage: '%s'.", sqlite3_errcode(database), sqlite3_errmsg( database ));
    }
}

@end
