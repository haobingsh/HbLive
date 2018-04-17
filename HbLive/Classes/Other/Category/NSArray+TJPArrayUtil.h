//
//  NSArray+TJPArrayUtil.h
//  TJPYingKe
//
//  Created by AaronTang on 2017/9/25.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (TJPArrayUtil)

/**
 检查是否越界和NSNull如果是返回nil

 @param index index
 @return 返回对象
 */
- (id)objectAtIndexChecked:(NSUInteger)index;

@end
