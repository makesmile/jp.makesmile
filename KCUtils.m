//
//  KCUtils.m
//  danmitsutype
//
//  Created by yu kawase on 13/01/18.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import "KCUtils.h"

@implementation KCUtils

static NSString* defaultServiceName;

+(void) defaultServiceName:(NSString*)value{
    defaultServiceName = value;
}

// create／update =============================================

+(BOOL) setPass:(NSString*)pass account:(NSString*)account{
    return [self setPass:pass account:account serviceName:defaultServiceName];
}

+(BOOL) setPass:(NSString*)pass account:(NSString*)account serviceName:(NSString *)serviceName{
    // create
    NSData* passData = [pass dataUsingEncoding:NSUTF8StringEncoding];
    
    // 存在すれば削除して再設定
    if([self hasPass:account serviceName:serviceName]){
        [self deletePass:account serviceName:serviceName];
    }
    
	NSMutableDictionary* item = [self createDefaultAttrs];
	[item setObject:serviceName forKey:(__bridge id)kSecAttrService];
    [item setObject:account forKey:(__bridge id)kSecAttrAccount];
    [item setObject:passData forKey:(__bridge id)kSecValueData];
    
    NSLog(@"add  --- serviceName:%@, account:%@, pass:%@", serviceName, account, pass);
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)item, nil);
    
    if((int)status != noErr){
        printf("SecItemAdd error = %d\n", (int)status);
        return NO;
    }else{
        return YES;
    }
}

// read =======================================

+(NSString*) getPass:(NSString*)account{
    return [self getPass:account serviceName:defaultServiceName];
}

+(NSString*) getPass:(NSString*)account serviceName:(NSString*)serviceName{
    NSMutableDictionary* query = [self createDefaultAttrs];
    [query setObject:(id)kCFBooleanFalse forKey:(__bridge id)kSecReturnAttributes]; // 属性はなしで
    [query setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [query setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit]; // 一個
    [query setObject:account forKey:(__bridge id)kSecAttrAccount]; // account
    [query setObject:serviceName forKey:(__bridge id)kSecAttrService]; // service
    
    CFDataRef cfResult = nil;
    OSStatus err = SecItemCopyMatching((__bridge CFDictionaryRef)query,(CFTypeRef*)&cfResult);
    NSData* result = (__bridge NSData*) cfResult;
    
    if (err == noErr) {
        NSLog(@"SecItemCopyMatching: noErr");
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    } else if(err == errSecItemNotFound) {
        NSLog(@"SecItemCopyMatching: errSecItemNotFound");
        return nil;
    } else {
        NSLog(@"SecItemCopyMatching: error(%ld)", err);
        return nil;
    }
}

// delete ========================================

+(BOOL) deletePass:(NSString*)account{
    // delete
    return [self deletePass:account serviceName:defaultServiceName];
}

+(BOOL) deletePass:(NSString*)account serviceName:(NSString*)serviceName{
    // delete
    NSMutableDictionary* deleteDic = [self createDefaultAttrs];
    [deleteDic setObject:account forKey:(__bridge id)kSecAttrAccount];
	[deleteDic setObject:serviceName forKey:(__bridge id)kSecAttrService];
	OSStatus status = SecItemDelete((__bridge CFDictionaryRef)deleteDic);
    
    NSLog(@"delete  --- serviceName:%@, account:%@", serviceName, account);
    
    if((int)status != noErr){
        printf("SecItemDelete error = %d\n", (int)status);
        return NO;
    }else{
        return YES;
    }
}

+(BOOL) deleteAllPass{
    NSMutableDictionary* deleteDic = [self createDefaultAttrs];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)deleteDic);
    if((int)status != noErr){
        printf("SecItemDelete error = %d\n", (int)status);
        return NO;
    }else{
        return YES;
    }
}

+(BOOL) deleteServicePass{
    return [self deleteServicePass:defaultServiceName];
}

+(BOOL) deleteServicePass:(NSString*)serviceName{
    NSMutableDictionary* deleteDic = [self createDefaultAttrs];
	[deleteDic setObject:serviceName forKey:(__bridge id)kSecAttrService];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)deleteDic);
    if((int)status != noErr){
        printf("SecItemDelete error = %d\n", (int)status);
        return NO;
    }else{
        return YES;
    }
}

// check ========================================

+(BOOL) hasPass:(NSString*)account{
    return [self hasPass:account serviceName:defaultServiceName];
}

+(BOOL) hasPass:(NSString*)account serviceName:(NSString*)serviceName{
    NSMutableDictionary* query = [self createDefaultAttrs];
    [query setObject:(id)kCFBooleanFalse forKey:(__bridge id)kSecReturnAttributes]; // 属性はなしで
    [query setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [query setObject:(__bridge id)kSecMatchLimitAll forKey:(__bridge id)kSecMatchLimit]; // 一個
    [query setObject:account forKey:(__bridge id)kSecAttrAccount]; // account
    [query setObject:serviceName forKey:(__bridge id)kSecAttrService]; // service
    
    NSLog(@"hasPass  --- serviceName:%@, account:%@", serviceName, account);
    
    CFDataRef cfResult = nil;
    OSStatus err = SecItemCopyMatching((__bridge CFDictionaryRef)query,(CFTypeRef*)&cfResult);
    
    if (err == noErr) {
        NSLog(@"SecItemCopyMatching: noErr");
        return YES;
    } else if(err == errSecItemNotFound) {
        NSLog(@"notFound");
        return NO;
    } else {
        NSLog(@"SecItemCopyMatching: error(%ld)", err);
        return NO;
    }
}

// dump =======================================

// http://ameblo.jp/xcc/entry-10813323465.html
+(void) kcTest{
    OSStatus status;
    
    // delete
    NSMutableDictionary* deleteDic = [NSMutableDictionary dictionary];
	[deleteDic setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [deleteDic setObject:@"danmitsutype" forKey:(__bridge id)kSecAttrService];
	status = SecItemDelete((__bridge CFDictionaryRef)deleteDic);
    printf("SecItemDelete error = %d\n", (int)status);
    
    // create
    NSString* passHash = @"dummy";
    NSData* passwordData = [passHash dataUsingEncoding:NSUTF8StringEncoding];
    NSString* account = @"dbPass";
    
	NSMutableDictionary* item = [NSMutableDictionary dictionary];
	[item setObject:(__bridge id)(kSecClassGenericPassword) forKey:(__bridge id<NSCopying>)(kSecClass)];
	[item setObject:@"danmitsutype" forKey:(__bridge id)kSecAttrService];
    [item setObject:account forKey:(__bridge id)kSecAttrAccount];
    [item setObject:passwordData forKey:(__bridge id)kSecValueData];
    [item setObject:(__bridge id)kSecAttrAccessibleWhenUnlockedThisDeviceOnly forKey:(__bridge id)kSecAttrAccessible];
    status = SecItemAdd((__bridge CFDictionaryRef)item, nil);
    printf("SecItemAdd error = %d\n", (int)status);
	
    [self dumpServiceItems:@"danmitsu"];
}

+(void) dumpServiceItems:(NSString*)serviceName{
    NSMutableDictionary* query = [NSMutableDictionary dictionary];
    
    [query setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [query setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnAttributes];
    [query setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [query setObject:(__bridge id)kSecMatchLimitAll forKey:(__bridge id)kSecMatchLimit];
    [query setObject:@"danmitsutype" forKey:(__bridge id)kSecAttrService];
    
    [self dumpItems:query];
}

+(void) dumpAll{
    NSMutableDictionary* query = [NSMutableDictionary dictionary];
    
    [query setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [query setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnAttributes];
    [query setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [query setObject:(__bridge id)kSecMatchLimitAll forKey:(__bridge id)kSecMatchLimit];
    
    [self dumpItems:query];
}

+(void)dumpItems:(NSDictionary*)query {
	
    CFArrayRef result = nil;
    OSStatus err = SecItemCopyMatching((__bridge CFDictionaryRef)query,(CFTypeRef*)&result);
    
    if (err == noErr) {
        NSLog(@"SecItemCopyMatching: noErr");
        NSLog(@"%@", result);
    } else if(err == errSecItemNotFound) {
        NSLog(@"SecItemCopyMatching: errSecItemNotFound");
    } else {
        NSLog(@"SecItemCopyMatching: error(%ld)", err);
    }
}

+(NSMutableDictionary*) createDefaultAttrs{
    NSMutableDictionary* item = [NSMutableDictionary dictionary];
	[item setObject:(__bridge id)(kSecClassGenericPassword) forKey:(__bridge id<NSCopying>)(kSecClass)];
//    [item setObject:(__bridge id)kSecAttrAccessibleWhenUnlockedThisDeviceOnly forKey:(__bridge id)kSecAttrAccessible];
    
    return item;
}

@end
