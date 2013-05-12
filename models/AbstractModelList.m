//
//  AbstractModelList.m
//  rssapp
//
//  Created by yu kawase on 13/03/01.
//  Copyright (c) 2013年 rssapp. All rights reserved.
//

#import "AbstractModelList.h"

@implementation AbstractModelList

-(id)init
{
    self = [super init];
    if(self){
        items = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void) clear
{
    [items removeAllObjects];
}

-(void) add:(AbstractModel*)item{
    [items addObject:item];
}

-(void) add:(AbstractModel*)item at:(int)at{
    [items insertObject:item atIndex:at];
}

-(void) replace:(AbstractModel*)item at:(int)at{
    if([items count] <= at){
        [self add:item];
    }else{
        [items replaceObjectAtIndex:at withObject:item];
    }
}

-(int) count
{
    return [items count];
}

-(AbstractModel*) get:(int)index
{
    return [items objectAtIndex:index];
}

-(AbstractModel*) getById:(int)id_
{
    int i,max = [self count];
    for(i=0;i<max;i++){
        if([self get:i].id_ == id_)
            return [self get:i];
    }
    
    return nil;
}

-(void) deleteItem:(int)id_{
    AbstractModel* item = [self getById:id_];
    [items removeObject:item];
}

-(void) removeObjectsInRange:(NSRange)range{
    [items removeObjectsInRange:range];
}

-(void) removeToTail:(int)begin{
    int num = [self count] - begin;
    if(num <= 0)
        return;
    
    [self removeObjectsInRange:NSMakeRange(begin, num)];
}

-(void) reload:(FMResultSet*)results{
    int i = 0;
    while([results next]){
        AbstractModel* rowModel = [self createModel:results];
        [self replace:rowModel at:i];
        i++;
    }
    
    [self removeToTail:i];
}

// abstract 
-(AbstractModel*) createModel:(FMResultSet*)resultSet{
    return nil;
}

@end
