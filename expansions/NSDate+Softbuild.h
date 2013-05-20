//
//  NSDate+Softbuild.h
//  fanap
//
//  Created by yu kawase on 13/05/13.
//  Copyright (c) 2013年 coode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Softbuild)
// 曜日のインデックス値を取得する
- (NSInteger) weekday;
// 短い曜日(例:火曜日ならば火など)を取得する
- (NSString*) stringShortweekday;
@end