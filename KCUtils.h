//
//  KCUtils.h
//  danmitsutype
//
//  Created by yu kawase on 13/01/18.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCUtils : NSObject

+(void) defaultServiceName:(NSString*)value;

// create／update
+(BOOL) setPass:(NSString*)pass account:(NSString*)account;
+(BOOL) setPass:(NSString*)pass account:(NSString*)account serviceName:(NSString*)serviceName;

// delete
+(BOOL) deleteAllPass;
+(BOOL) deleteServicePass;
+(BOOL) deleteServicePass:(NSString*) serviceName;
+(BOOL) deletePass:(NSString*)account;
+(BOOL) deletePass:(NSString*)account serviceName:(NSString*)serviceName;

// read
+(NSString*) getPass:(NSString*)account;
+(NSString*) getPass:(NSString*)account serviceName:(NSString*)serviceName;

// check
+(BOOL) hasPass:(NSString*)account;
+(BOOL) hasPass:(NSString*)account serviceName:(NSString*)serviceName;

+(void) dumpAll;

@end
