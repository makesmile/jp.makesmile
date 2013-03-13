//
//  BaseDb.h
//  reedly
//
//  Created by yu kawase on 12/12/06.
//  Copyright (c) 2012年 reedly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface BaseDb : NSObject{
    
}

// 初期化
+(void)create;
+(void) createWithDbFileName:(NSString*)dbFileName_;

+(sqlite3*) getDatabase;
+(void) lock;
+(void) unlock;
+(void) beginTransaction;
+(void) commit;
+(void) rollback;

+(BOOL) hasError;
+(void) showErrorMessage;

@end
