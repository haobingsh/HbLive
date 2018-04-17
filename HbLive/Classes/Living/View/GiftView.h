//
//  GiftView.h
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GiftItem;
@interface GiftView : UIView

/** 礼物数据*/
@property (nonatomic, strong) NSMutableArray <GiftItem *>*giftData;
/** 选择礼物回调*/
@property (nonatomic, copy) void(^sendGiftBlock)(NSString *username, NSString *giftName, NSString *giftIcon);

/** instancetype*/
+ (instancetype)giftViewWithFrame:(CGRect)frame;


/** 展示礼物列表*/
- (void)actionSheetViewShow;
/** 隐藏*/
- (void)tappedCancel;

@end
