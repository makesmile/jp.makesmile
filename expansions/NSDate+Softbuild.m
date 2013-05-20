//
//  NSDate+Softbuild.m
//  fanap
//
//  Created by yu kawase on 13/05/13.
//  Copyright (c) 2013年 coode. All rights reserved.
//

#import "NSDate+Softbuild.h"

@implementation NSDate (Softbuild)

/*****************************************************
 * 曜日のインデックス値を取得する
 * @return 曜日のインデックス値(1を日曜日とした値)
 *****************************************************/
- (NSInteger) weekday {
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* comps = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    return comps.weekday;
}

/*****************************************************
 * 短い曜日(例:火曜日ならば火など)を取得する
 * @return 曜日
 *****************************************************/
- (NSString*) stringShortweekday {
    static NSString* const array[] = {nil, @"日", @"月", @"火", @"水", @"木", @"金", @"土"};
    NSInteger index = [self weekday];
    if (index > 7) index = 0;
    return array[index];
}

@end