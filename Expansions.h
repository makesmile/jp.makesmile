//
//  Expansions.h
//  kaimono
//
//  Created by yu kawase on 13/01/05.
//  Copyright (c) 2013年 kaimono. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Expansions : NSObject

@end

@interface NSString (util)

-(BOOL)empty;

@end

// ▼ stack と queue ==================================
// http://ishidak.blogspot.jp/2010/04/iphone-objective-cnsmutablearraystackqu.html

//NSMutableArray+QueueAdditions.h

@interface NSMutableArray (QueueAdditions)
- (id) dequeue;
- (void) enqueue:(id)obj;
@end

//NSMutableArray+StackAdditions.h

@interface NSMutableArray (StackAdditions)

- (id)pop;
- (void)push:(id)obj;

@end
