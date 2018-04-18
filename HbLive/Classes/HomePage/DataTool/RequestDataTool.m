//
//  RequestDataTool.m
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "RequestDataTool.h"
#import "RefreshGifHeader.h"




@interface RequestDataTool ()

@property (nonatomic, strong) HbSessionManager *sessionManager;


@end


static RequestDataTool *dataTool = nil;

@implementation RequestDataTool

- (HbSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[HbSessionManager alloc] init];
    }
    return _sessionManager;
}


+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataTool = [[RequestDataTool alloc] init];
    });
    return dataTool;
}


/** 导航栏标签数据*/
- (void)getNavigationTagModels:(void(^)(NSArray <NavigationTagItem *>*tagModels))resultBlock {
    
    [self.sessionManager request:RequestTypeGet urlStr:kNavigationTagAPI parameter:nil resultBlock:^(id responseObject, NSError *error) {
        if (error) {
            TJPLog(@"%@", error.localizedDescription);
            return;
        }
        NSArray <NavigationTagItem *>*tagModels = [NavigationTagItem mj_objectArrayWithKeyValuesArray:responseObject[@"tabs"]];
        resultBlock(tagModels);
    }];
}

/** 广告页数据 */
- (void)getAdvertiseModel:(void(^)(AdvertiseModel *model))resultBlock {
    [self.sessionManager request:RequestTypeGet urlStr:kAdvertiseAPI parameter:nil resultBlock:^(id responseObject, NSError *error) {
        if (error) {
            TJPLog(@"%@", error.localizedDescription);
            return;
        }
        NSMutableArray *tmpArr = [AdvertiseModel mj_objectArrayWithKeyValuesArray:responseObject[@"resources"]];
        if (!tmpArr.count) {
            return;
        }
        AdvertiseModel *model = [tmpArr firstObject];
        resultBlock(model);
    }];
}




/** 轮播数据*/
- (void)getTopCarouselModels:(void(^)(NSArray <BannerItem *>*carouselModels))resultBlock {
    [self.sessionManager request:RequestTypeGet urlStr:kHomeTopCarouselAPI parameter:nil resultBlock:^(id responseObject, NSError *error) {
        if (error) {
            TJPLog(@"%@", error.localizedDescription);
            return;
        }
        NSArray <BannerItem *>*carouselModels = [BannerItem mj_objectArrayWithKeyValuesArray:responseObject[@"ticker"]];
        resultBlock(carouselModels);
    }];
}



/** 获取热门数据*/
- (void)getHotPageModelsWithTableView:(UITableView *)tableView  result:(void(^)(NSMutableArray <HotLiveItem *>*hotModels))resultBlock {
    [self.sessionManager request:RequestTypeGet urlStr:kHotLiveAPI parameter:nil resultBlock:^(id responseObject, NSError *error) {
        [tableView.mj_header endRefreshing];
        if (error) {
            TJPLog(@"%@", error.localizedDescription);
            return;
        }
        NSMutableArray <HotLiveItem *>*hotModels = [HotLiveItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        resultBlock(hotModels);
    }];
    
}

/** 获取直播间用户数据*/
- (void)getLivingRoomTopUserModelsWithLiveID:(NSUInteger)liveID  result:(void(^)(NSMutableArray <LiveRoomTopUserItem *>*topUserModels))resultBlock {
    
    NSString *url = [NSString stringWithFormat:@"%@%lu&s_sg=c2681fa2c3c60a48e6de037e84df86f9&s_sc=100&s_st=1481858627", kLivingRoomUserInfoAPI, (unsigned long)liveID];
    TJPLog(@"%@", url);
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:nil resultBlock:^(id responseObject, NSError *error) {
        if (error) {
            TJPLog(@"%@", error.localizedDescription);
            return;
        }
        NSMutableArray *topUserModels = [LiveRoomTopUserItem mj_objectArrayWithKeyValuesArray:responseObject[@"users"]];
        resultBlock(topUserModels);
    }];
}


/** 礼物数据*/
- (void)getLivingRoomGiftModels:(void(^)(NSMutableArray <GiftItem *>*giftModels))resultBlock {
    [self.sessionManager request:RequestTypeGet urlStr:kGiftInfoAPI parameter:nil resultBlock:^(id responseObject, NSError *error) {
        if (error) {
            TJPLog(@"%@", error.localizedDescription);
            return;
        }
        NSMutableArray *giftModels = [GiftItem mj_objectArrayWithKeyValuesArray:responseObject[@"gifts"]];
        resultBlock(giftModels);
    }];
}


@end
