//
//  AdView.m
//  girsgossip
//
//  Created by yu kawase on 13/03/07.
//  Copyright (c) 2013年 rssapp. All rights reserved.
//

#import "AdView.h"

#define MEDIA_NO @"MEDIA-b98e22d"
#define SPOT_NO 1

@implementation AdView

@synthesize adView;
@synthesize onAdFailed;
@synthesize onAdLoaded;

-(id) initWithMediano:(NSString*)mediaNo_ spotNo:(int)spotNo_{
    self = [super init];
    if(self){
        mediatNo = mediaNo_;
        spotNo = spotNo_;
        [self initialize];
    }
    
    return self;
}

-(void) initialize{
    self.frame = CGRectMake(0, 0, 320, 50);
    self.backgroundColor = UIColorFromHex(0x3f3f3f);
    self.adView = [[AdstirView alloc]initWithOrigin:CGPointMake(0, 0)];
	self.adView.media = mediatNo;
	self.adView.spot = spotNo;
    self.adView.delegate = self;
	[self addSubview:self.adView];
}

-(void) start{
    [adView start];
}

- (void)adstirDidReceiveAd:(AdstirView*)adstirview{
	//広告取得に成功した時
    if(onAdLoaded != nil){
        onAdLoaded(self);
    }
}
- (void)adstirDidFailToReceiveAd:(AdstirView*)adstirview{
	//広告取得に失敗した時
    if(onAdFailed != nil){
        onAdFailed(self);
    }
}

-(void) setRootViewController:(UIViewController *)rootViewController{
    self.adView.rootViewController = rootViewController;
}

@end
