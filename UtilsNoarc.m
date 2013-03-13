//
//  UtilsNoarc.m
//  joshi2ch
//
//  Created by yu kawase on 12/11/12.
//  Copyright (c) 2012年 joshi2ch. All rights reserved.
//

#import "UtilsNoarc.h"

@implementation UtilsNoarc

+ (NSString*) mimeTypeForFileAtPath: (NSString *) path {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return nil;
    }
    // Borrowed from http://stackoverflow.com/questions/5996797/determine-mime-type-of-nsdata-loaded-from-a-file
    // itself, derived from  http://stackoverflow.com/questions/2439020/wheres-the-iphone-mime-type-database
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (CFStringRef)[path pathExtension], NULL);
    CFStringRef mimeType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!mimeType) {
        return @"application/octet-stream";
    }
    return [NSMakeCollectable((NSString *)mimeType) autorelease];
}

@end
