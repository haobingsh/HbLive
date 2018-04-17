//
//  TJPCacheHelper.m
//  TJPYingKe
//
//  Created by Walkman on 2017/3/20.
//  Copyright © 2017年 AaronTang. All rights reserved.
//  

#import "CacheHelper.h"

@implementation CacheHelper
/** 获取广告图片*/
+ (NSString *)getAdvertiseImage {
    return [UserDefaults objectForKey:AdImage_Name];
}

/** 存储广告图片*/
+ (void)setAdvertiseImage:(NSString *)imageName {
    [UserDefaults setObject:imageName forKey:AdImage_Name];
    [UserDefaults synchronize];
}



/** 广告链接*/
+ (NSString *)getAdvertiseLink {
    return [UserDefaults objectForKey:AdImage_Link];
}

/** 存储广告链接*/
+ (void)setAdvertiseLink:(NSString *)linkStr {
    [UserDefaults setObject:linkStr forKey:AdImage_Link];
    [UserDefaults synchronize];
}



/** 清除缓存数据*/
+ (void)removeAdvertiseAllData {
    //清除缓存图片
    [UserDefaults removeObjectForKey:AdImage_Name];
    //清除缓存链接
    [UserDefaults removeObjectForKey:AdImage_Link];
}


@end
