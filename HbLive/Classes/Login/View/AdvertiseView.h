//
//  TJPAdvertiseView.h
//  TJPYingKe
//
//  Created by Walkman on 2017/3/20.
//  Copyright © 2017年 AaronTang. All rights reserved.
//  广告视图

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, AdvertiseViewType) {
    AdvertiseViewTypeUnknow = 0,
    AdvertiseViewTypeFullScreen,             //全屏
    AdvertiseViewTypeLogo                    //带Logo
};

typedef void(^AdvertiseViewClick)(NSString *link);

@interface AdvertiseView : UIView
/** 本地图片 用于没有网路图片时显示*/
@property (nonatomic, copy) NSString *localImageName;
/** 点击回调*/
@property (nonatomic, copy) AdvertiseViewClick clickBlock;


/** 初始化方法*/
+ (instancetype)AdvertiseViewWithType:(AdvertiseViewType)type;

/** 显示广告*/
- (void)advertiseShow;
/** 清除广告图片缓存*/
- (void)cleanAdvertiseImageCache;

@end
