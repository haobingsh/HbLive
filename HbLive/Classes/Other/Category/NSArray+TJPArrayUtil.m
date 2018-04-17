//
//  NSArray+TJPArrayUtil.m
//  TJPYingKe
//
//  Created by AaronTang on 2017/9/25.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "NSArray+TJPArrayUtil.h"

@implementation NSArray (TJPArrayUtil)

- (id)objectAtIndexChecked:(NSUInteger)index {
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

@end
