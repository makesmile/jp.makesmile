//
//  ImageCache.h
//  cocosearch
//
//  Created by yu kawase on 12/12/26.
//  Copyright (c) 2012年 cocosearch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"

typedef void (^onload_image_t)(UIImage* image, NSString* key, BOOL useCache);

@interface ImageCache : NSObject

+(void) create;
+(void) clear;
+(BOOL) hasCache:(NSString*)url;
+(UIImage*) getChache:(NSString*)url;
+(void) setCache:(UIImage*)image forKey:(NSString*)url;

+(void) loadImage:(NSString*)url callback:(onload_image_t)callback;

@end
