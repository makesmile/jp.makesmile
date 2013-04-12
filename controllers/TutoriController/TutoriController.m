//
//  TutoriController.m
//  rssapp
//
//  Created by yu kawase on 13/03/10.
//  Copyright (c) 2013年 rssapp. All rights reserved.
//

#import "TutoriController.h"

@implementation TutoriController

static NSMutableDictionary* viewList;


+(void) initialize{
    viewList = [[NSMutableDictionary alloc] init];
}

// public

+(TutoriView*)createView:(NSString*)key text:(NSString*)text{
    if([[NSUserDefaults standardUserDefaults] boolForKey:key])
        return nil;
    TutoriView* tView = [[TutoriView alloc] initWithKey:key withText:text];
    [viewList setObject:tView forKey:key];
    
    return tView;
}

+(void) did:(NSString*)key{
    TutoriView* tView = [viewList objectForKey:key];
    if(tView == nil) return;
    [tView did];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void) show:(NSString*)key{
    TutoriView* tView = [viewList objectForKey:key];
    if(tView == nil) return;
    [tView show];
}

+(void) hide:(NSString*)key{
    TutoriView* tView = [viewList objectForKey:key];
    if(tView == nil) return;
    [tView hide];
}


@end
