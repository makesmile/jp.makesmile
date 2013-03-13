//
//  ImageFile.h
//  kaimono
//
//  Created by yu kawase on 13/01/10.
//  Copyright (c) 2013年 kaimono. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"

@interface ImageFile : NSObject{
    NSFileManager* fileManager;
    NSString* itemImageDir;
}

+(ImageFile*)getInstance;
-(void) saveItemImage:(UIImage*)image itemId:(int)itemId;
-(UIImage*) getItemImage:(int)itemId;
-(void) deleteItemImage:(int)itemId;

@end
