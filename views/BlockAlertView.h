//
//  BlockAlertView.h
//  kaimono
//
//  Created by yu kawase on 13/02/12.
//  Copyright (c) 2013年 kaimono. All rights reserved.
//

// block インタフェース AlertView

#import <UIKit/UIKit.h>

typedef void (^clicked_t)(UIAlertView* alertView, int index);
typedef void (^cancelAlert_t)(UIAlertView* alertView);
typedef void (^didPresentAlert_t)(UIAlertView* alertView);
typedef void (^willPresentAlert_t)(UIAlertView* alertView);
typedef void (^willDismissWithButtonIndex_t)(UIAlertView* alertView, int index);
typedef void (^didDismissWithButtonIndex_t)(UIAlertView* alertView, int index);
typedef BOOL (^alertViewShouldEnableFirstOtherButton_t)(UIAlertView* alertView);

@interface BlockAlertView : UIAlertView<UIAlertViewDelegate>{
    // callbacks ==============
    clicked_t clickedT;
    cancelAlert_t cancelAlertT;
    didPresentAlert_t didPresentAlertT;
    willPresentAlert_t willPresentAlertT;
    willDismissWithButtonIndex_t willDismissWithButtonIndexT;
    didDismissWithButtonIndex_t didDismissWithButtonIndexT;
    alertViewShouldEnableFirstOtherButton_t alertViewShouldEnableFirstOtherButtonT;
}

@property (strong) clicked_t clickedT;
@property (strong) cancelAlert_t cancelAlertT;
@property (strong) didPresentAlert_t didPresentAlertT;
@property (strong) willPresentAlert_t willPresentAlertT;
@property (strong) willDismissWithButtonIndex_t willDismissWithButtonIndexT;
@property (strong) didDismissWithButtonIndex_t didDismissWithButtonIndexT;
@property (strong) alertViewShouldEnableFirstOtherButton_t alertViewShouldEnableFirstOtherButtonT;

@end
