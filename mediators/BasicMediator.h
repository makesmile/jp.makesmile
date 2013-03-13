//
//  BasicMediators.h
//  koinamida
//
//  Created by yu kawase on 12/10/14.
//  Copyright (c) 2012年 koinamida. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface BasicMediator : NSObject{
    
    UIWindow* window;
    
    // ローディング
    BOOL isLoading;
    UIView* loadingView;
    
    // トースト
    UIButton* toastButton;
    UILabel* toastLabel;
    
    // 設定
    NSUserDefaults* userDefaults;
}

-(id) initWithWindow:(UIWindow*)window_;

// 子クラスで上書き
-(void) initialize;
-(void) fadeoutSplash;
-(void) becomeActive;
-(void) memoryWarning;

// トースト
-(void) showToast:(NSString*)toastText;
// ローディング
-(void) showLoading;
-(void) hideLoading;

-(CGRect) getWindowFrame;
-(UIView*) getWindow;
-(float) getWindowHeight;
-(BOOL) isDekaDisplay;

-(void) setLoadingLayerParent:(UIView*)parentView;
-(dispatch_queue_t) mainQueue;
-(dispatch_queue_t) globalQueue;

@end
