//
//  ImageFile.m
//  kaimono
//
//  Created by yu kawase on 13/01/10.
//  Copyright (c) 2013年 kaimono. All rights reserved.
//

/**
 * Singleton
 * TODO new封じ
 */

#import "ImageFile.h"

#define IMAGE_DIR_NAME @"itemImages"

@implementation ImageFile

static ImageFile* instance;


+(ImageFile*)getInstance{
    if(instance == nil){
        instance = [[ImageFile alloc] init];
    }
    
    return instance;
}

-(id) init{
    self = [super init];
    if(self){
        [self initialize];
    }
    
    return self;
}

-(void) initialize{
    fileManager = [NSFileManager defaultManager];
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cacheDirPath = [array objectAtIndex:0];
    itemImageDir = [cacheDirPath stringByAppendingPathComponent:IMAGE_DIR_NAME];
    
    if(![fileManager fileExistsAtPath:itemImageDir]){
        // フォルダがなかったら作る
        NSError* error = nil;
        if (![fileManager createDirectoryAtPath:itemImageDir withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"cant create directory:%@", error.description);
        }else{
            NSLog(@"create directory");
        }
    }
}

-(void) saveItemImage:(UIImage*)image itemId:(int)itemId{
    NSData *data = UIImagePNGRepresentation(image);
    NSString* fileName = [NSString stringWithFormat:@"%d.png", itemId];
    NSString *filePath = [itemImageDir stringByAppendingPathComponent:fileName];
    if ([data writeToFile:filePath atomically:YES]) {
        NSLog(@"saveFile: OK");
    } else {
        NSLog(@"saveFile: Error");
    }
}

-(UIImage*) getItemImage:(int)itemId{
    NSString* fileName = [NSString stringWithFormat:@"%d.png", itemId];
    NSString *filePath = [itemImageDir stringByAppendingPathComponent:fileName];
    
    UIImage* image = [[UIImage alloc] initWithContentsOfFile:filePath];
    if(image == nil){
        return nil;
    }
    return [Utils scaledImageWithImage:image];
}

-(void) deleteItemImage:(int)itemId{
    NSString* fileName = [NSString stringWithFormat:@"%d.png", itemId];
    NSString *filePath = [itemImageDir stringByAppendingPathComponent:fileName];
    
    if([fileManager fileExistsAtPath:filePath]){
        NSError* error = nil;
        [fileManager removeItemAtPath:filePath error:nil];
        if(error != nil){
            NSLog(@"delete error : %@", error.description);
        }else{
            NSLog(@"deleteSuccess");
        }
    }else{
        NSLog(@"no delete target");
    }
}

@end
