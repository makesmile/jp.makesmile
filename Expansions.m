//
//  Expansions.m
//  kaimono
//
//  Created by yu kawase on 13/01/05.
//  Copyright (c) 2013年 kaimono. All rights reserved.
//

#import "Expansions.h"

@implementation Expansions

@end

@implementation NSString(util)

-(BOOL)empty{
    if(self == nil || [self length] == 0) { //string is empty or nil
        return YES;
    }
    
    if(![[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        //string is all whitespace
        return YES;
    }
    
    return NO;
}

@end

//NSMutableArray+QueueAdditions.m

@implementation NSMutableArray (QueueAdditions)
// Queues are first-in-first-out, so we remove objects from the head
- (id) dequeue {
    // if ([self count] == 0) return nil; // to avoid raising exception (Quinn)
    id headObject = [self objectAtIndex:0];
    if (headObject != nil) {
        [self removeObjectAtIndex:0];
    }
    return headObject;
}

// Add to the tail of the queue (no one likes it when people cut in line!)
- (void) enqueue:(id)anObject {
    [self addObject:anObject];
    //this method automatically adds to the end of the array
}
@end


@implementation NSMutableArray (StackAdditions)

- (id)pop
{
    // nil if [self count] == 0
    id lastObject = [self lastObject];
    if (lastObject)
        [self removeLastObject];
    return lastObject;
}

- (void)push:(id)obj
{
    [self addObject: obj];
}

@end