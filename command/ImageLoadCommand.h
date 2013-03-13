//
//  ImageLoadCommand.h
//  rssapp
//
//  Created by yu kawase on 13/03/01.
//  Copyright (c) 2013年 rssapp. All rights reserved.
//

#import "URLLoadCommand.h"
#import "ImageCache.h"

typedef void (^onImageLoaded_t)(URLLoadOperation* operation, UIImage* image);

@interface ImageLoadCommand : URLLoadCommand{
    onImageLoaded_t onImageLoaded;
}

-(void) setImageLoaded:(onImageLoaded_t)onImageLoaded_;

@end
