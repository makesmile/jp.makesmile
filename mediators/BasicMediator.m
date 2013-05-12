//
//  BasicMediators.m
//  koinamida
//
//  Created by yu kawase on 12/10/14.
//  Copyright (c) 2012年 koinamida. All rights reserved.
//

#import "BasicMediator.h"

@implementation BasicMediator

-(id) initWithWindow:(UIWindow*)window_{
    NSLog(@"initWithWindow");
    self = [super init];
    if(self){
        window = window_;
        userDefaults = [NSUserDefaults standardUserDefaults];
        [self initialize];
        [self createLoading];
        [self initialized];
    }
    
    return self;
}

// ▼protected ============================================

-(void) initialize{}
-(void) initialized{}
-(void) becomeActive{}
-(void) memoryWarning{}

// ▼private ================================================

-(void) createLoading{
    toastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    toastButton.frame = CGRectMake(0, 0, 220, 100);
    toastButton.center = CGPointMake(160, 300);
    toastButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    toastButton.layer.cornerRadius = 5;
    toastButton.hidden = YES;
    toastButton.alpha = 0.0f;
    // トーストラベル
    toastLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 100)];
    toastLabel.backgroundColor = [UIColor clearColor];
    toastLabel.textColor = [UIColor whiteColor];
    toastLabel.textAlignment = UITextAlignmentCenter;
    toastLabel.font = [UIFont systemFontOfSize:16];
    toastLabel.lineBreakMode  = UILineBreakModeWordWrap;
    toastLabel.numberOfLines  = 3;
    [toastButton addSubview:toastLabel];
    
    // ローディングレイヤ
    loadingView = [[UIView alloc] initWithFrame:[window bounds]];
    [loadingView setBackgroundColor:[UIColor blackColor]];
    loadingView.alpha = 0.0f;
    UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingView addSubview:indicator];
    [indicator setFrame:CGRectMake ((320/2)-20, (480/2)-20, 40, 40)];
    [indicator startAnimating];
    
    [window addSubview:loadingView];
    [window addSubview:toastButton];
}

-(void) onShowToast
{
    [self hideToast];
}

-(void) onHideToast
{
    toastButton.alpha = 0;
    toastButton.hidden = YES;
}

/**
 * トースト非表示
 * @param
 * @return
 */
-(void) hideToast:(id)target
{
    [self onHideToast];
}

/**
 * トースト非表示
 * @param
 * @return
 */
-(void) hideToast
{
    [UIView beginAnimations:nil context: NULL];
    [UIView setAnimationDelay:2.0f];
    [UIView setAnimationDuration:0.5f];
    toastButton.alpha = 0.0f;
    [UIView setAnimationDidStopSelector:@selector(onHideToast)];
    
    [UIView commitAnimations];
}


// ▼public ===============================================

-(dispatch_queue_t) mainQueue{
    return dispatch_get_main_queue();
}

-(dispatch_queue_t) globalQueue{
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

/**
 * トースト表示
 * @param
 * @return
 */
-(void) showToast:(NSString*)toastText
{
    toastButton.alpha = 0;
    toastButton.hidden = NO;
    toastLabel.text = toastText;
    
    [UIView beginAnimations:nil context: NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(onShowToast)];
    toastButton.alpha = 1.0f;
    [UIView setAnimationDuration:0.5];
    
    [UIView commitAnimations];
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

-(CGRect) getWindowFrame{
    return window.frame;
}

-(UIView*) getWindow{
    return window;
}

-(float) getWindowHeight{
    return [self getWindowFrame].size.height;
}

-(BOOL) isDekaDisplay{
    return ([self getWindowHeight] > 480);
}

-(void) fadeoutSplash{
    NSString* imgName = ([self getWindowFrame].size.height > 480) ? @"Default-568h" : @"Default";
    UIImage *img = [UIImage imageNamed:imgName];
	CGRect rect = CGRectMake( 0.0f , 0.0f, window.frame.size.width, window.frame.size.height);
    //    CGRect rect = CGRectMake( 0.0f , 20.0f, 320, 568 );
	UIImageView *imageview = [[UIImageView alloc] initWithFrame:rect];
	imageview.image = img;
	[window addSubview:imageview];
    
	window.alpha = 1.0;
    
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.9f];
	imageview.alpha = 0.0;
	[UIView commitAnimations];
}

-(void) setLoadingLayerParent:(UIView*)parentView{
    [loadingView removeFromSuperview];
    loadingView.frame = parentView.frame;
    [parentView addSubview:loadingView];
}


@end
