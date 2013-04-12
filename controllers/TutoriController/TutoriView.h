//
//  TutoriView.h
//  rssapp
//
//  Created by yu kawase on 13/03/10.
//  Copyright (c) 2013年 rssapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Utils.h"

typedef enum TutoriArrowPosition
{
	LEFT_TOP,
    LEFT_MIDDLE,
    LEFT_BOTTOM,
    TOP_LEFT,
    TOP_MIDDLE,
    TOP_RIGHT,
    RIGHT_TOP,
    RIGHT_MIDDLE,
    RIGHT_BOTTOM,
    BOTTOM_LEFT,
    BOTTOM_MIDDLE,
    BOTTOM_RIGHT
} TutoriArrowPosition;

@interface TutoriView : UIView{
    // views
    UILabel* textLabel;
    UIImageView* arrowImage;
    UIView* view_;
    
    // point
    CGPoint point;
    
    // text
    NSString* key;
    NSString* text;
    
    // params
    float width;
    TutoriArrowPosition arrowPosition;
}

-(id) initWithKey:(NSString*)key_ withText:(NSString*)text_;

-(void) setText:(NSString*)text_;
-(void) setPoint:(CGPoint)point_;
-(void) setWidth:(float)width_;
-(void) setArrowPosition:(TutoriArrowPosition)arrowPosition_;

-(void) show;
-(void) hide;
-(void) create;
-(void) did;

@end
