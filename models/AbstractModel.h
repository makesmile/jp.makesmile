//
//  AbstractModel.h
//  rssapp
//
//  Created by yu kawase on 13/03/01.
//  Copyright (c) 2013年 rssapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"
#import "Utils.h"
#import "NSDate+Softbuild.h"

@interface AbstractModel : NSObject{
    int id_;
    NSDate* createdDate;
    NSDate* updatedDate;
    NSString* createdAt;
    NSString* updatedAt;
}

-(id) initWithResultSet:(FMResultSet*)resultSet;
-(void) setParams:(FMResultSet*)resultSet;
-(NSDate*) stringToDate:(NSString*)string;

@property int id_;
@property (readonly) NSDate* createdDate;
@property (readonly) NSDate* updatedDate;
@property (readonly) NSString* createdAt;
@property (readonly) NSString* updatedAt;

@end
