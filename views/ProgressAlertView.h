//
//  ProgressAlertView.h
//  danmitsutype
//
//  Created by yu kawase on 13/02/22.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressAlertView : UIAlertView{
    UIProgressView* progressView;
}

-(void) update:(float)current total:(float)total;

@end
