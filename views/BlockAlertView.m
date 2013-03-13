//
//  BlockAlertView.m
//  kaimono
//
//  Created by yu kawase on 13/02/12.
//  Copyright (c) 2013年 kaimono. All rights reserved.
//

#import "BlockAlertView.h"

@implementation BlockAlertView

@synthesize clickedT;
@synthesize cancelAlertT;
@synthesize didPresentAlertT;
@synthesize willPresentAlertT;
@synthesize willDismissWithButtonIndexT;
@synthesize didDismissWithButtonIndexT;
@synthesize alertViewShouldEnableFirstOtherButtonT;

-(id) init{
    self = [super init];
    if(self){
        [self initialize];
    }
    
    return self;
}

-(void) initialize{
    self.delegate = self;
}

// UIAlertViewDelegate ==================================

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(clickedT != nil){
        clickedT(alertView, buttonIndex);
    }
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)alertViewCancel:(UIAlertView *)alertView{
    if(cancelAlertT != nil){
        cancelAlertT(alertView);
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView{
    if(willPresentAlertT != nil){
        willPresentAlertT(alertView);
    }
}

- (void)didPresentAlertView:(UIAlertView *)alertView{
    if(didPresentAlertT != nil){
        didPresentAlertT(alertView);
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(willDismissWithButtonIndexT != nil){
        willDismissWithButtonIndexT(alertView, buttonIndex);
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(didDismissWithButtonIndexT != nil){
        didDismissWithButtonIndexT(alertView, buttonIndex);
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView{
    
    if(alertViewShouldEnableFirstOtherButtonT != nil){
        return alertViewShouldEnableFirstOtherButtonT(alertView);
    }
    
    return true;
}


@end
