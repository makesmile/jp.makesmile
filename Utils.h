//
//  Utils.h
//  koinamida2
//
//  Created by yu kawase on 12/10/20.
//  Copyright (c) 2012年 koinamida. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <sqlite3.h>
#import "Expansions.h"

// http://twobitlabs.com/2011/03/some-great-uicolor-resources/ より
#define UIColorFromHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

@interface Utils : NSObject

+(long long)getMilliSec;
+(NSString*)getMilliSecString;
+(NSString*) sha256:(NSString*)text;
+(NSString*) sha256:(NSString*)text withKeta:(int)keta;
+(NSDate*)pubDateToNSDate:(NSString*)pubDate;
+(NSString*)dateToString:(NSDate*)date format:(NSString*)format;
+(NSDate*)stringToDate:(NSString*)pubDate format:(NSString*)format;
+ (NSString*) mimeTypeForFileAtPath: (NSString *) path;
+ (NSString*) encodeURIComponent:(NSString*) s;
+(NSString*) createReviewUrl:(NSString*)appId;
+(NSDictionary*)objToJson:(NSObject*)obj;

+(NSString*)getShortWeekString:(NSDate*)date;
+(int) getWeekIndex:(NSDate*)date;

+ (UInt64)getEpochSeconds;
+ (UInt64)getEpochMilliSeconds;

+(int) getMajorVersion;
+(int) getMinorVersion;
+(BOOL) isDataInitialized;

+ (NSUInteger)randIntRange:(NSRange)range;

+(BOOL) hasClass:(NSString*)className;
+(int) getAppMajorVersion;
+(int) getAppMinorVersion;
+(float) getAppVersion;

//▼ sqlite ========================================
+(NSString*)stmToString:(sqlite3_stmt*)statement index:(int)index;
+(int)stmToInt:(sqlite3_stmt*)statement index:(int)index;
+(double)stmToDouble:(sqlite3_stmt*)statement index:(int)index;
+(void)bindText:(sqlite3_stmt*)statement text:(NSString*)text index:(int)index;
+(void)bindInt:(sqlite3_stmt*)statement value:(int)value index:(int)index;
+(void)bindDouble:(sqlite3_stmt*)statement value:(double)value index:(int)index;

// ▼画像 ===================================
+ ( UIImage* ) scaledImageWithImage:( UIImage* ) image;
// http://iphone-dev.doorblog.jp/archives/3019022.html からコピペ
+ (UIImage *)getResizedImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height;
+ (UIImage *)getResizedImage:(UIImage *)image size:(CGSize)size;
+ (UIImage *)getResizedImage:(UIImage *)image width:(CGFloat)width;
+ (UIImage *)getResizedImage:(UIImage *)image height:(CGFloat)height;

// http://qiita.com/items/3ad3aa92024b4f7401cd
+ (UIImage*)clipImage:(UIImage *)image rect:(CGRect)rect;

@end
