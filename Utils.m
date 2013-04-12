//
//  Utils.m
//  koinamida2
//
//  Created by yu kawase on 12/10/20.
//  Copyright (c) 2012年 koinamida. All rights reserved.
//

#import "Utils.h"

@implementation Utils

static NSString* const array[] = {nil, @"日", @"月", @"火", @"水", @"木", @"金", @"土"};

+(NSString*)getShortWeekString:(NSDate*)date{
    int weekIndex = [self getWeekIndex:date];
    if (weekIndex > 7) weekIndex = 0;
    return array[weekIndex];
}

+(int) getWeekIndex:(NSDate *)date{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* comps = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    return comps.weekday;
}

+(long long)getMilliSec{
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    return timestamp * 1000;
}

+(NSString*)getMilliSecString{
    return [NSString stringWithFormat:@"%lld", [Utils getMilliSec]];
}

+(NSString*) sha256:(NSString *)text{
    
    const char *s=[text cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, keyData.length, digest);
    NSData *out =
    [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}

+(NSString*) sha256:(NSString*)text withKeta:(int)keta{
    return [[self sha256:text] substringToIndex:keta];
}

+(NSDate*)pubDateToNSDate:(NSString*)pubDate{
    NSDateFormatter* dateFormatter;
    dateFormatter = [[NSDateFormatter alloc] init];
    
    // TODO なんかUSに設定しないとうまくとれない
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"US"]];
    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZZ"];
    NSDate* date = [dateFormatter dateFromString:pubDate];
        
    return date;
}

+ (NSString*)filenameExtensionFromMimeType:(NSString*)mimeTYpe
{
    CFStringRef uti = UTTypeCreatePreferredIdentifierForTag(
                                                            kUTTagClassMIMEType, (__bridge CFStringRef)mimeTYpe, NULL);
    
    NSString* filenamExtension =
    (__bridge NSString*)UTTypeCopyPreferredTagWithClass(uti, kUTTagClassFilenameExtension);
    
    CFRelease(uti);
    
    return filenamExtension;
}

+(NSDate*)stringToDate:(NSString*)pubDate format:(NSString*)format{
    NSDateFormatter* dateFormatter;
    dateFormatter = [[NSDateFormatter alloc] init];
    
    // TODO なんかUSに設定しないとうまくとれない
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"US"]];
    [dateFormatter setDateFormat:format];
    NSDate* date = [dateFormatter dateFromString:pubDate];
    
    return date;
}

+ (UInt64)getEpochSeconds
{
    return (UInt64)floor(CFAbsoluteTimeGetCurrent() + kCFAbsoluteTimeIntervalSince1970);
}

+ (UInt64)getEpochMilliSeconds
{
    return (UInt64)floor((CFAbsoluteTimeGetCurrent() + kCFAbsoluteTimeIntervalSince1970) * 1000.0);
}

+(int) getMajorVersion{
    NSArray *aOsVersions = [[[UIDevice currentDevice]systemVersion] componentsSeparatedByString:@"."];
    return [[aOsVersions objectAtIndex:0] intValue];
}

+(int) getMinorVersion{
    NSArray *aOsVersions = [[[UIDevice currentDevice]systemVersion] componentsSeparatedByString:@"."];
    return [[aOsVersions objectAtIndex:1] intValue];
}

+(float)windowHeight{
    return [[UIScreen mainScreen] bounds].size.height;
}

+(NSString*)dateToString:(NSDate*)date format:(NSString*)format{
    NSDateFormatter *toStringFormatter;
    toStringFormatter = [[NSDateFormatter alloc] init];
    toStringFormatter.dateFormat  = format;
    return [toStringFormatter stringFromDate:date];
}

+ (NSString*) mimeTypeForFileAtPath: (NSString *) path {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return nil;
    }
    // Borrowed from http://stackoverflow.com/questions/5996797/determine-mime-type-of-nsdata-loaded-from-a-file
    // itself, derived from  http://stackoverflow.com/questions/2439020/wheres-the-iphone-mime-type-database
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef mimeType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!mimeType) {
        return @"application/octet-stream";
    }
    return (__bridge NSString *)mimeType;
}

+(NSString*) cacheDir{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray* cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cacheDir = [cachePaths objectAtIndex:0];
    
    return cacheDir;
}

+ (NSString*) encodeURIComponent:(NSString*) s {
    return ((__bridge NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                (CFStringRef)s,
                                                                NULL,
                                                                (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                kCFStringEncodingUTF8));
}

+ (NSUInteger)randIntRange:(NSRange)range{
	return range.location + (NSUInteger)([self randInt] * (range.length + 1.0) / (RAND_MAX + 1.0));
}

+ (NSUInteger)randInt
{
	[self staticInit];
	return rand();
}

+ (void)staticInit
{
	static BOOL initFlag = FALSE;
	if (!initFlag) {
		srand(time(NULL));
		initFlag = TRUE;
	}
}

+(BOOL) is35Inch{
    return ([self windowHeight] < 568);
}

+(BOOL) hasClass:(NSString *)className{
    Class clazz = NSClassFromString(className);
    return (clazz != nil);
}

+(int) getAppMajorVersion{
    return (int) [self getAppVersion];
}

+(int) getAppMinorVersion{
    float version = [self getAppVersion];
    float tmp = version - (float)[self getAppMajorVersion];
    return (int) round(tmp*100.0f);
}

+(float) getAppVersion{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return [version floatValue];
}

// ▼ sqlite ==============================================

+(NSString*)stmToString:(sqlite3_stmt*)statement index:(int)index{
    
    if(sqlite3_column_text(statement, index) != NULL){
        NSString* str = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, index)];
        return [str stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    }
    
    return nil;
}

+(int)stmToInt:(sqlite3_stmt*)statement index:(int)index{
    return sqlite3_column_int(statement, index);
}

+(double)stmToDouble:(sqlite3_stmt*)statement index:(int)index{
    return sqlite3_column_double(statement, index);
}

+(void)bindText:(sqlite3_stmt*)statement text:(NSString*)text index:(int)index;{
    sqlite3_bind_text(statement, index, [text UTF8String], -1, SQLITE_TRANSIENT);
}

+(void)bindInt:(sqlite3_stmt*)statement value:(int)value index:(int)index{
    sqlite3_bind_int(statement, index, value);
}

+(void)bindDouble:(sqlite3_stmt*)statement value:(double)value index:(int)index{
    sqlite3_bind_double(statement, index, value);
}

+(NSString*) createReviewUrl:(NSString *)appId{
    return [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&mt=8&type=Purple+Software", appId];
}

// ▼画像 ========================================

+ ( UIImage* ) scaledImageWithImage:( UIImage* ) image {
    CGFloat scale = [[ UIScreen mainScreen ] scale ];
    CGSize size = image.size;
    if( round( image.scale ) != round( scale )) {
        CGSize newSize = CGSizeMake( size.width / scale, size.height / scale );
        UIGraphicsBeginImageContextWithOptions( newSize, NO, scale );
        [ image drawInRect: CGRectMake( 0.0, 0.0, newSize.width, newSize.height )];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return image;
}

+ (UIImage *)getResizedImage:(UIImage *)image width:(CGFloat)width{
    float rate = image.size.height / image.size.width;
    float height = rate * width;
    return [self getResizedImage:image width:width height:height];
}

+ (UIImage *)getResizedImage:(UIImage *)image height:(CGFloat)height{
    float rate = image.size.width / image.size.height;
    float width = rate * height;
    
    return [self getResizedImage:image width:width height:height];
}

+ (UIImage *)getResizedImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height
{
	if (UIGraphicsBeginImageContextWithOptions != NULL) {
		UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, [[UIScreen mainScreen] scale]);
	} else {
		UIGraphicsBeginImageContext(CGSizeMake(width, height));
	}
    
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetInterpolationQuality(context, kCGInterpolationHigh); // 高品質リサイズ
    
	[image drawInRect:CGRectMake(0.0, 0.0, width, height)];
    
	UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return resizedImage;
}

+ (UIImage *)getResizedImage:(UIImage *)image size:(CGSize)size
{
	return [self getResizedImage:image width:size.width height:size.height];
}

// http://qiita.com/items/3ad3aa92024b4f7401cd
+ (UIImage*)clipImage:(UIImage *)image rect:(CGRect)rect {
    
    // 画像のクリッピング iPad3 Retina対応
    float scale = [[UIScreen mainScreen] scale];
    CGRect scaledRect = CGRectMake(rect.origin.x * scale,
                                   rect.origin.y * scale,
                                   rect.size.width * scale,
                                   rect.size.height * scale);
    
    CGImageRef clip = CGImageCreateWithImageInRect(image.CGImage,scaledRect);
    UIImage *clipedImage = [UIImage imageWithCGImage:clip
                                               scale:scale
                                         orientation:UIImageOrientationUp];
//    CGImageRelease(clip);
    
    return clipedImage;
}

@end
