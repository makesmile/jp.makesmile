//
//  AbstractModelList.h
//  rssapp
//
//  Created by yu kawase on 13/03/01.
//  Copyright (c) 2013年 rssapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractModel.h"

@interface AbstractModelList : NSObject{
    NSMutableArray* items;
}

-(void) clear;
-(void) add:(AbstractModel*)item;
-(void) add:(AbstractModel*)item at:(int)at;
-(void) replace:(AbstractModel*)item at:(int)at;
-(int) count;
-(AbstractModel*) get:(int)index;
-(AbstractModel*) getById:(int)id_;
-(void) deleteItem:(int)id_;
-(void) removeObjectsInRange:(NSRange)range;
-(void) removeToTail:(int)begin;

@end
