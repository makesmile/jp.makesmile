//
//  TutoriView.m
//  rssapp
//
//  Created by yu kawase on 13/03/10.
//  Copyright (c) 2013年 rssapp. All rights reserved.
//

/**
 http://qiita.com/items/059243259de464e4a156
 */

#import "TutoriView.h"

@implementation TutoriView

-(id) initWithKey:(NSString*)key_ withText:(NSString*)text_
{
    self = [super init];
    if (self) {
        key = key_;
        text = text_;
        [self initialize];
    }
    return self;
}

-(void) initialize{
    self.userInteractionEnabled = NO;
    
    // 角丸
    view_ = [[UIView alloc] init];
    view_.backgroundColor = UIColorFromHex(0x333333);
    view_.layer.cornerRadius = 5;
    view_.clipsToBounds = NO;
    view_.layer.masksToBounds = NO;
    [[view_ layer] setBorderColor:[[UIColor whiteColor] CGColor]];
    [[view_ layer] setBorderWidth:2.0];
    view_.layer.shadowColor = [UIColor blackColor].CGColor;
    view_.layer.shadowOpacity = 0.5f;
    view_.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    [self addSubview:view_];
    
    // label
    textLabel = [[UILabel alloc] init];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:10.0f];
    [view_ addSubview:textLabel];
    
    // arrow
    arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tutoriArrow"]];
    [self addSubview:arrowImage];
}

-(void) setWidth:(float)width_{
    width = width_;
}

-(void) setText:(NSString*)text_{
    text = text_;
}

-(void) setPoint:(CGPoint)point_{
    point = point_;
}

-(void) setArrowPosition:(TutoriArrowPosition)arrowPosition_{
    arrowPosition = arrowPosition_;
}

-(void) create{
    float textWidth = (width == 0) ? 100 : width;
    textLabel.frame = CGRectMake(10, 10, textWidth, 0);
    textLabel.lineBreakMode  = UILineBreakModeWordWrap;
    textLabel.numberOfLines  = 0;
    textLabel.text = text;
    //高さを自動で合わせる
    [textLabel sizeToFit];
    
    CGRect frame = textLabel.frame;
    frame.size.width += 20;
    frame.size.height += 20;
    
    view_.frame = frame;
    self.frame = CGRectMake(point.x, point.y, frame.size.width, frame.size.height);
    
    view_.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    self.alpha = 0.0f;
    [self updateArrorImage];
    [self startAnimation];
}

-(void) show{
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

-(void) hide{
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
    }];
}

-(void) did{
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void) startAnimation{
    NSLog(@"startAnimation");
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDelegate:self];
    
    float delay = (float)[Utils randIntRange:NSMakeRange(0, 10)] / 10.0f;
    
    // アニメーションを開始する時間
    [UIView setAnimationDelay:delay];
    // アニメーションを実行する時間
    [UIView setAnimationDuration:0.7];
    // アニメーションを繰り返す回数
    [UIView setAnimationRepeatCount:10000];
    // アニメーション完了後元に戻る
    [UIView setAnimationRepeatAutoreverses:YES];
    
    // 大きさを縦横2倍にする
    CGAffineTransform translate = CGAffineTransformMakeTranslation(0, 10);
    [self setTransform:translate];
    
    // アニメーション開始
    [UIView commitAnimations];
}

-(void) updateArrorImage{
    static float arrowWidth = 16;
    static float arrowHeight = 25;
    static float padding = 12;
    
    CGSize size = view_.frame.size;
    switch (arrowPosition) {
        case LEFT_TOP:
            arrowImage.frame = CGRectMake(-arrowWidth+padding, padding, arrowWidth, arrowHeight);
            break;
            
        case LEFT_MIDDLE:
            arrowImage.frame = CGRectMake(-arrowWidth+padding, (size.height - arrowHeight)/2 + padding-2, arrowWidth, arrowHeight);
            break;
            
        case LEFT_BOTTOM:
            arrowImage.frame = CGRectMake(-arrowWidth+padding, size.height - arrowHeight, arrowWidth, arrowHeight);
            break;
            
        case RIGHT_TOP:
            arrowImage.frame = CGRectMake(size.width + 10-2, padding, arrowWidth, arrowHeight);
            arrowImage.transform = CGAffineTransformScale(arrowImage.transform, -1, 1);
            break;
            
        case RIGHT_MIDDLE:
            arrowImage.frame = CGRectMake(size.width + 10-2, (size.height - arrowHeight)/2 + padding, arrowWidth, arrowHeight);
            arrowImage.transform = CGAffineTransformScale(arrowImage.transform, -1, 1);
            break;
            
        case RIGHT_BOTTOM:
            arrowImage.frame = CGRectMake(size.width + 10-2, size.height - arrowHeight, arrowWidth, arrowHeight);
            arrowImage.transform = CGAffineTransformScale(arrowImage.transform, -1, 1);
            break;
            
        case TOP_LEFT:
            arrowImage.frame = CGRectMake(padding+1, -arrowWidth+10+2, arrowHeight, arrowWidth);
            arrowImage.transform = CGAffineTransformMakeRotation(M_PI/2);
            break;
            
        case TOP_MIDDLE:
            arrowImage.frame = CGRectMake((size.width/2)-(arrowHeight/2) + (padding/2), -arrowHeight+10+2, arrowHeight, arrowWidth);
            arrowImage.transform = CGAffineTransformMakeRotation(M_PI/2);
            break;
            
        case TOP_RIGHT:
            arrowImage.frame = CGRectMake(size.width-arrowWidth+4, -arrowHeight+10+6.6f, arrowWidth, arrowHeight);
            arrowImage.transform = CGAffineTransformMakeRotation(M_PI/2);
            break;
            
        case BOTTOM_LEFT:
            arrowImage.frame = CGRectMake(padding+1, size.height+8, arrowHeight, arrowWidth);
            arrowImage.transform = CGAffineTransformMakeRotation(-M_PI/2);
            break;
            
        case BOTTOM_MIDDLE:
            arrowImage.frame = CGRectMake((size.width/2)-(arrowHeight/2) + (padding/2), size.height+8, arrowHeight, arrowWidth);
            arrowImage.transform = CGAffineTransformMakeRotation(-M_PI/2);
            break;
            
        case BOTTOM_RIGHT:
            arrowImage.frame = CGRectMake(size.width-arrowHeight, size.height+8, arrowHeight, arrowWidth);
            arrowImage.transform = CGAffineTransformMakeRotation(-M_PI/2);
            break;
            
        default:
            arrowImage.frame = CGRectMake(-arrowHeight+padding, padding, arrowHeight, arrowWidth);
            break;
    }
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
