//
//  JpgUploadCommand.m
//  fanap
//
//  Created by yu kawase on 13/04/17.
//  Copyright (c) 2013年 coode. All rights reserved.
//

#import "JpgUploadCommand.h"

@implementation JpgUploadCommand

-(NSData*) createData{
    return [[NSData alloc] initWithData:UIImageJPEGRepresentation(image, 0.8f)];
}

-(NSString*) contentType{
    return @"image/jpeg";
}

-(NSString*) ext{
    return @"jpg";
}

@end
