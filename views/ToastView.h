//
//  ToastView.h
//  fanap
//
//  Created by yu kawase on 13/05/03.
//  Copyright (c) 2013年 coode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToastView : UIView{
    UIButton* button;
    UILabel* label;
}

-(void) setLabel:(NSString*)labelText;
-(void) align:(NSTextAlignment)align;

@end
