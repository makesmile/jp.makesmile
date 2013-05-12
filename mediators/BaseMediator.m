//
//  BaseMediator.m
//  coode
//
//  Created by yu kawase on 13/03/28.
//  Copyright (c) 2013年 coode. All rights reserved.
//

#import "BaseMediator.h"

@implementation BaseMediator

-(id) initWithWindow:(UIWindow*)window_{
    self = [super init];
    if(self){
        window = window_;
        toastView = [[ToastView alloc] init];
        [self initialize];
    }
    
    return self;
}

-(void) showToast:(NSString *)text{
    [toastView align:NSTextAlignmentCenter];
    [self showToast_:text];
}

-(void) showToast_:(NSString *)text{
    [toastView setLabel:text];
    [toastView removeFromSuperview];
    [window addSubview:toastView];
    
    toastView.alpha = 0;
    [UIView animateWithDuration:0.5f animations:^{
        toastView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f delay:2.0f options:UIViewAnimationOptionShowHideTransitionViews animations:^{
            toastView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

-(void) showToast:(NSString *)text align:(NSTextAlignment)align{
    [toastView align:align];
    [self showToast_:text];
}

-(void) initialize{}
-(void) becomeActive{}
-(void) memoryWarning{}
-(dispatch_queue_t) mainQueue{
    return dispatch_get_main_queue();
}
-(dispatch_queue_t) globalQueue{
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

@end
