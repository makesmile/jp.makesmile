//
//  PngUploadCommand.m
//  fanap
//
//  Created by yu kawase on 13/04/17.
//  Copyright (c) 2013年 coode. All rights reserved.
//

#import "PngUploadCommand.h"

@implementation PngUploadCommand

// Override 
-(NSData*) createData{
    return [[NSData alloc] initWithData:UIImagePNGRepresentation(image)];
}

-(NSString*) contentType{
    return @"image/png";
}

-(NSString*) ext{
    return @"png";
}

@end
