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

+(void) loadImage:(NSString*)url callback:(onload_image_t)callback{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // キャッシュがあればそれ使って終わり
        if([self hasCache:url]){
            callback([cacheList objectForKey:url], url);
            return;
        }
        
        // なければ取りにいく
        UIImage* image = [Utils scaledImageWithImage:
                          [UIImage imageWithData:
                           [NSData dataWithContentsOfURL:[NSURL URLWithString:url]]]];
        if(image == nil){
            return;
        }
        [self setCache:image forKey:url];
        
        callback(image, url);
    });
}

//thumbImageView.image = nil;
//// 画像なし
//if([imageUrl isEqualToString:@""]){
//    return;
//}
//
//CGRect imageFrame = [self createImageFrame];
//UIImage* image = [ImageCache getChache:imageUrl];
//if(image){
//    UIImage* scaledImage = [Utils getResizedImage:image width:imageFrame.size.width height:imageFrame.size.height];
//    [thumbImageView setImage:scaledImage];
//    thumbImageView.frame = imageFrame;
//    return;
//}
//
//// TODO imageDic(キャッシュはどっかで消さないとやばい)
//image = [[UIImage alloc] init];
//[ImageCache setCache:image forKey:imageUrl];
//
//dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//    NSString* requestUrl = [NSString stringWithFormat:@"%@%@", IMAGE_URL, imageUrl];
//    UIImage* image = [Utils scaledImageWithImage:
//                      [UIImage imageWithData:
//                       [NSData dataWithContentsOfURL:[NSURL URLWithString:requestUrl]]]];
//    if(image == nil){
//        return;
//    }
//    [ImageCache setCache:image forKey:imageUrl];
//    if(imageUrl != coco.thumbImage){
//        [indicator stopAnimating];
//        return;
//    }
//    UIImage* scaledImage = [Utils getResizedImage:image width:imageFrame.size.width height:imageFrame.size.height];
//    // UIの更新はメインスレッド
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        [thumbImageView setImage:scaledImage];
//        [indicator stopAnimating];
//        thumbImageView.frame = imageFrame;
//    });
//});

@end
