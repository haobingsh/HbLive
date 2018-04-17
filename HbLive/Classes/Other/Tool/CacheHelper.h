//
//  TJPCacheHelper.h
//  TJPYingKe
//
//  Created by Walkman on 2017/3/20.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheHelper : NSObject
/** 获取广告图片*/
+ (NSString *)getAdvertiseImage;

/** 存储广告图片*/
+ (void)setAdvertiseImage:(NSString *)imageName;

/** 广告链接*/
+ (NSString *)getAdvertiseLink;

/** 存储广告链接*/
+ (void)setAdvertiseLink:(NSString *)linkStr;


/** 清除缓存数据*/
+ (void)removeAdvertiseAllData;


@end
