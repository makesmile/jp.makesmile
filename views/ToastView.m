//
//  ToastView.m
//  fanap
//
//  Created by yu kawase on 13/05/03.
//  Copyright (c) 2013年 coode. All rights reserved.
//

#import "ToastView.h"

@implementation ToastView

-(id) init{
    self = [super init];
    if(self){
        [self initialize];
    }
    
    return self;
}

-(void) initialize{
    [self setViews];
}

-(void) setViews{
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 220, 100);
    button.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];
//    [button addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];

    label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 80)];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 3;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.userInteractionEnabled = NO;
    
    [button addSubview:label];
    [self addSubview:button];
    self.frame = CGRectMake(50, 200, 220, 100);
}

//-(void) hide{
//    NSLog(@"hide");
//    [UIView animateWithDuration:0.3f animations:^{
//        self.alpha = 0.0f;
//    }];
//}

// public ===================

-(void) setLabel:(NSString*)labelText{
    label.text = labelText;
}

-(void) align:(NSTextAlignment)align{
    label.textAlignment = align;
}


@end
