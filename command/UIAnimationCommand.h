//
//  UIAnimationCommand.h
//  danmitsutype
//
//  Created by yu kawase on 13/01/14.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import "AbstractCommand.h"

// http://shinen1.wordpress.com/2012/07/26/objective-c-block%E3%81%A8gcd/
typedef void (^uianimation_complete_t)(BOOL finished);

@interface UIAnimationCommand : AbstractCommand{
    // params
    float delay;
    float duration;
    UIViewAnimationOptions options;
    dispatch_block_t animationBlock;
    uianimation_complete_t completeBlock;
}

-(id) initWithDuration:(float)duration_
                 delay:(float)delay_
               options:(UIViewAnimationOptions)options_
        animationBlock:(dispatch_block_t)animationBlock_
         completeBlock:(uianimation_complete_t)completeBlock_;

@end
