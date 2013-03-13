//
//  ImageLoadCommand.m
//  rssapp
//
//  Created by yu kawase on 13/03/01.
//  Copyright (c) 2013年 rssapp. All rights reserved.
//

#import "ImageLoadCommand.h"

@implementation ImageLoadCommand

-(void) setImageLoaded:(onImageLoaded_t)onImageLoaded_{
    onImageLoaded = onImageLoaded_;
}

// Override
-(void) internalExecute:(NSData*)data{
    NSString* url = [urlLoadOperation getUrl];
    if([ImageCache hasCache:url]){
        UIImage* image = [ImageCache getChache:url];
        NSData* data = [[NSData alloc] initWithData:UIImagePNGRepresentation( image )];
        [self onComplete:data];
        return;
    }
    
    urlLoadOperation.onFinished = ^(URLLoadOperation* operation, NSData* data){
        UIImage* image = [UIImage imageWithData:data];
        [ImageCache setCache:image forKey:url];
        if(onImageLoaded != nil){
            onImageLoaded(operation, image);
        }
        if(onFinished != nil){
            onFinished(operation, data);
        }
        
        [self onComplete:data];
    };
    
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    [queue addOperation:urlLoadOperation];
}

@end
