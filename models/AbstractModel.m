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

-(id) initWithResultSet:(FMResultSet*)resultSet{
    self = [super init];
    if(self){
        id_ = [resultSet intForColumn:@"id"];
        [self setParams:resultSet];
    }
    
    return self;
}

// abstract
-(void) setParams:(FMResultSet*)resultSet{}

@end
