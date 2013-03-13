//
//  AbstractViewController.h
//  reedly
//
//  Created by yu kawase on 12/12/06.
//  Copyright (c) 2012年 reedly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Utils.h"

@class Mediator;

@interface AbstractViewController : UIViewController{
    Mediator* mediator;
    UIView* loadingView;
    BOOL isLoading;
    float windowHeight;
    // トースト
    UIButton* toastButton;
    UILabel* toastLabel;

}

-(id) initWithMediator:(Mediator*)mediator_;
-(void) initialize;
-(void) initialized;
-(void) showLoading;
-(void) hideLoading;
-(void) updateLoadingView;
-(void) createLoading;

@end
