//
//  AdView.h
//  girsgossip
//
//  Created by yu kawase on 13/03/07.
//  Copyright (c) 2013年 rssapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdstirView.h"
#import "Utils.h"
#import "NADView.h"

@class AdView;

typedef void(^onAdLoaded_t)(AdView* adView);
typedef void(^onAdFailed_t)(AdView* adView);

@interface AdView : UIView <AdstirViewDelegate>{
    AdstirView* adView;
    
    onAdFailed_t onAdFailed;
    onAdFailed_t onAdLoaded;
    
    NSString* mediatNo;
    int spotNo;
}

@property (strong) onAdFailed_t onAdFailed;
@property (strong) onAdLoaded_t onAdLoaded;
@property (nonatomic, retain) AdstirView* adView;
@property (nonatomic) UIViewController* rootViewController;

-(id) initWithMediano:(NSString*)mediaNo_ spotNo:(int)spotNo_;
-(void) start;

@end
