//
//  AbstractModel.h
//  rssapp
//
//  Created by yu kawase on 13/03/01.
//  Copyright (c) 2013年 rssapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMResultSet.h"

@interface AbstractModel : NSObject{
    int id_;
}

-(id) initWithResultSet:(FMResultSet*)resultSet;
-(void) setParams:(FMResultSet*)resultSet;

@property int id_;

@end
