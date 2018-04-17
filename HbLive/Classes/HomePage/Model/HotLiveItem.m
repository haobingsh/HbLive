//
//  TJPHotLiveItem.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/9.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "HotLiveItem.h"
#import "CreatorItem.h"
#import "ExtraItem.h"

@implementation HotLiveItem

//解决关键字冲突
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID": @"id"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"creator" : @"CreatorItem",
             @"extra" : @"ExtraItem"};
}



@end
