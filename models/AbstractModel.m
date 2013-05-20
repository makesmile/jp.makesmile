//
//  AbstractModel.m
//  rssapp
//
//  Created by yu kawase on 13/03/01.
//  Copyright (c) 2013年 rssapp. All rights reserved.
//

#import "AbstractModel.h"

@implementation AbstractModel

@synthesize id_;
@synthesize createdAt;
@synthesize updatedAt;

-(id) initWithResultSet:(FMResultSet*)resultSet{
    self = [super init];
    if(self){
        id_ = [resultSet intForColumn:@"id"];
        createdAt = [resultSet stringForColumn:@"created_at"];
        updatedAt = [resultSet stringForColumn:@"updated_at"];
        [self setParams:resultSet];
    }
    
    return self;
}

-(NSDate*) createdDate{
    if(createdDate == nil)
        createdDate = [self stringToDate:createdAt];
    return createdDate;
}

-(NSDate*) updatedDate{
    if(updatedDate == nil)
        updatedDate = [self stringToDate:updatedAt];
    return updatedDate;
}

-(NSDate*) stringToDate:(NSString*)string{
    return [Utils stringToDate:string format:@"yyyy-MM-dd'T'HH:mm:sszzz"];
}

// abstract
-(void) setParams:(FMResultSet*)resultSet{}

@end
