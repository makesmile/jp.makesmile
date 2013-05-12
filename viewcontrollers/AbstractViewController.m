//
//  AbstractViewController.m
//  reedly
//
//  Created by yu kawase on 12/12/06.
//  Copyright (c) 2012年 reedly. All rights reserved.
//

#import "AbstractViewController.h"

@interface AbstractViewController ()

@end

@implementation AbstractViewController

-(id) initWithMediator:(Mediator*)mediator_{
    self = [self init];
    if(self){
        mediator = mediator_;
    }
    
    return self;
}

-(id) init{
    self = [super init];
    if(self){
        isLoading = NO;
        windowHeight = [[UIScreen mainScreen] bounds].size.height;
        toastView = [[ToastView alloc] init];
        [self initialize];
        [self internalInitialize];
        [self initialized];
    }
    
    return self;
}

-(void) internalInitialize{
    [self createLoading];
}

// 子クラス実装
-(void) initialize{}
-(void) initialized{}

-(void) createLoading{
    toastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    toastButton.frame = CGRectMake(0, 0, 200, 100);
    toastButton.center = CGPointMake(160, 300);
    toastButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    toastButton.layer.cornerRadius = 5;
    toastButton.hidden = YES;
    toastButton.alpha = 0.0f;
    // トーストラベル
    toastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    toastLabel.backgroundColor = [UIColor clearColor];
    toastLabel.textColor = [UIColor whiteColor];
    toastLabel.textAlignment = UITextAlignmentCenter;
    toastLabel.font = [UIFont systemFontOfSize:16];
    toastLabel.lineBreakMode  = UILineBreakModeWordWrap;
    toastLabel.numberOfLines  = 2;
    [toastButton addSubview:toastLabel];
    
    // ローディングレイヤ
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [loadingView setBackgroundColor:[UIColor blackColor]];
    loadingView.alpha = 0.0f;
    UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingView addSubview:indicator];
    [indicator setFrame:CGRectMake ((320/2)-20, (400/2)-20, 40, 40)];
    [indicator startAnimating];
    
    [self.view addSubview:loadingView];
    [self.view addSubview:toastButton];
}

-(void) updateLoadingView{
    [loadingView removeFromSuperview];
    [self.view addSubview:loadingView];
}

/**
 * ローディング表示
 * @param
 * @return
 */
-(void) showLoading
{
    if(isLoading)
        return;
    
    isLoading = YES;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    // [UIView setAnimationDidStopSelector:@selector(_onFinishLoading)];
    loadingView.hidden = NO;
    [UIView setAnimationDuration:0.5f];
    loadingView.alpha = 0.5f;
    [UIView commitAnimations];
}

/**
 * ローディング非表示
 * @param
 * @return
 */
-(void) hideLoading
{
    if(!isLoading)
        return;
    
    isLoading = NO;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5f];
    loadingView.alpha = 0.0f;
    [UIView commitAnimations];
}

-(void) showToast:(NSString *)text{
    [toastView setLabel:text];
    [toastView removeFromSuperview];
    [self.view addSubview:toastView];
    
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

-(void) globalQueue:(dispatch_block_t)block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

-(void) mainQueue:(dispatch_block_t)block{
    dispatch_async(dispatch_get_main_queue(), block);
}

@end
