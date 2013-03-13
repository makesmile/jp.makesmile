//
//  ProgressAlertView.m
//  danmitsutype
//
//  Created by yu kawase on 13/02/22.
//  Copyright (c) 2013年 danmitsutype. All rights reserved.
//

#import "ProgressAlertView.h"

@implementation ProgressAlertView

-(id) init{
    self = [super init];
    if(self){
        [self initialize];
    }
    
    return self;
}

-(void) initialize{
    progressView = [[UIProgressView alloc] initWithFrame:CGRectMake( 12, 80, 260, 30 )];
    [self addSubview:progressView];
    
    [self setTitle:@"データ取得中"];
}

// ▼ public ==================================

-(void) update:(float)current total:(float)total{
    [self setMessage:[NSString stringWithFormat:@"%f/%f", current, total]];
    progressView.progress = current / total;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
