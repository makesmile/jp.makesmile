//
//  UIAnimationCommand.m
//  danmitsutype
//
//  Created by yu kawase on 13/01/14.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import "UIAnimationCommand.h"

@implementation UIAnimationCommand

-(id) initWithDuration:(float)duration_
                 delay:(float)delay_
               options:(UIViewAnimationOptions)options_
        animationBlock:(dispatch_block_t)animationBlock_
         completeBlock:(uianimation_complete_t)completeBlock_{
    self = [super init];
    if(self){
        duration = duration_;
        delay = delay_;
        options = options_;
        animationBlock = animationBlock_;
        completeBlock = completeBlock_;
    }
    
    return self;
}

-(void) internalExecute{
//    dispatch_async(dispatch_get_main_queue(), ^{
        [self startAnimation];
//    });
}

-(void) startAnimation{
    [UIView animateWithDuration:duration
                          delay:delay
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:animationBlock
                     completion:^(BOOL finished) {
                         completeBlock(finished);
                         [delegate onComplete:self data:nil];
                     }
     ];
}

@end
