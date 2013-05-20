//
//  ImageCache.m
//  cocosearch
//
//  Created by yu kawase on 12/12/26.
//  Copyright (c) 2012年 cocosearch. All rights reserved.
//

#import "ImageCache.h"

@implementation ImageCache

static NSMutableDictionary* cacheList;
static NSOperationQueue* queue;

+(void) create{
    cacheList = [[NSMutableDictionary alloc] init];
    queue = [[NSOperationQueue alloc] init];
}

+(void) clear{
    [cacheList removeAllObjects];
    [queue cancelAllOperations];
}

+(void) clear:(NSString*)key{
    [cacheList removeObjectForKey:key];
}

+(BOOL) hasCache:(NSString*)url{
    return ([cacheList objectForKey:url] != nil);
}

+(UIImage*) getChache:(NSString*)url{
    if(![self hasCache:url]){
        return nil;
    }
    
    return [cacheList objectForKey:url];
}

+(void) setCache:(UIImage*)image forKey:(NSString*)url{
    [cacheList setObject:image forKey:url];
}

static int loadingNum = 0;
+(void) loadImage:(NSString*)url callback:(onload_image_t)callback{
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        loadingNum++;
        // キャッシュがあればそれ使って終わり
        if([self hasCache:url]){
            callback([cacheList objectForKey:url], url, YES);
            loadingNum--;
            return;
        }
        
        URLLoadOperation* op = [[URLLoadOperation alloc] init];
        [op setUrl:url];
        op.onFinished = ^(URLLoadOperation* operation, NSData* data){
            loadingNum--;
            UIImage* image = [UIImage imageWithData:data];
            if(image == nil) return;
            [self setCache:image forKey:url];
            callback(image, url, NO);
        };
        op.onError = ^(URLLoadOperation* operation, NSError* error){
            loadingNum--;
        };
        [queue addOperation:op];
        
        NSLog(@"%d", queue.operationCount);
    });
}

@end
