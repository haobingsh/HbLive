//
//  RequestDataTool.h
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveRoomTopUserItem.h"
#import "NavigationTagItem.h"
#import "AdvertiseModel.h"
#import "HotLiveItem.h"
#import "BannerItem.h"
#import "GiftItem.h"

@interface RequestDataTool : NSObject

+ (instancetype)shareInstance;

/** 导航栏标签数据*/
- (void)getNavigationTagModels:(void(^)(NSArray <NavigationTagItem *>*tagModels))resultBlock;

/** 广告页数据 */
- (void)getAdvertiseModel:(void(^)(AdvertiseModel *model))resultBlock;

/** 轮播数据*/
- (void)getTopCarouselModels:(void(^)(NSArray <BannerItem *>*carouselModels))resultBlock;


/** 获取热门数据*/
- (void)getHotPageModelsWithTableView:(UITableView *)tableView  result:(void(^)(NSMutableArray <HotLiveItem *>*hotModels))resultBlock;


/** 获取直播间用户数据*/
- (void)getLivingRoomTopUserModelsWithLiveID:(NSUInteger)liveID  result:(void(^)(NSMutableArray <LiveRoomTopUserItem *>*topUserModels))resultBlock;

/** 礼物数据*/
- (void)getLivingRoomGiftModels:(void(^)(NSMutableArray <GiftItem *>*giftModels))resultBlock;


@end
