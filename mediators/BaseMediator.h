//
//  BaseMediator.h
//  coode
//
//  Created by yu kawase on 13/03/28.
//  Copyright (c) 2013年 coode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToastView.h"

@interface BaseMediator : NSObject{
    UIWindow* window;
    ToastView* toastView;
}

-(id) initWithWindow:(UIWindow*)window_;

-(void) initialize;
-(void) becomeActive;
-(void) memoryWarning;
-(void) showToast:(NSString*)text;
-(void) showToast:(NSString *)text align:(NSTextAlignment)align;
-(dispatch_queue_t) mainQueue;
-(dispatch_queue_t) globalQueue;


@end
