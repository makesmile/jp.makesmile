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

+(void) create{
    cacheList = [[NSMutableDictionary alloc] init];
}

+(void) clear{
    [cacheList removeAllObjects];
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        sleep((float)loadingNum * 0.1f); // TODO うーん
        loadingNum++;
//        NSLog(@"add:loadingNum:%d", loadingNum);
        // キャッシュがあればそれ使って終わり
        if([self hasCache:url]){
            callback([cacheList objectForKey:url], url, YES);
            loadingNum--;
//            NSLog(@"sub:loadingNum:%d", loadingNum);
            return;
        }
        
        // なければ取りにいく
        UIImage* image = [Utils scaledImageWithImage:
                          [UIImage imageWithData:
                           [NSData dataWithContentsOfURL:[NSURL URLWithString:url]]]];
        if(image == nil){
            NSLog(@"fail : %@", url);
            loadingNum--;
//            NSLog(@"sub:loadingNum:%d", loadingNum);
            return;
        }
        loadingNum--;
//        NSLog(@"sub:loadingNum:%d", loadingNum);
        [self setCache:image forKey:url];
        callback(image, url, NO);
    });
}

@end
