//
//  LiveRoomTopUserItem.m
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "LiveRoomTopUserItem.h"

@implementation LiveRoomTopUserItem

//解决关键字冲突
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Description": @"description",
             @"ID" : @"id"};
}


@end
