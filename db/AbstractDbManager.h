//
//  AbstractDbManager.h
//  naver
//
//  Created by yu kawase on 13/04/06.
//  Copyright (c) 2013年 naver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbstractDbManager : NSObject{
    NSLock* dbLock;
}

@end
