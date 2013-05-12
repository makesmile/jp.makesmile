//
//  TutoriController.h
//  rssapp
//
//  Created by yu kawase on 13/03/10.
//  Copyright (c) 2013年 rssapp. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import "TutoriView.h"

@interface TutoriController : NSObject{

}

+(void) initialize;
+(TutoriView*)createView:(NSString*)key text:(NSString*)text;
+(void) did:(NSString*)key;

+(void) show:(NSString*)key;
+(void) hide:(NSString*)key;

@end
