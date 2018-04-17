//
//  TJPGiftChanneView.h
//  TestAnimation
//
//  Created by Walkman on 2017/3/1.
//  Copyright © 2017年 AaronTang. All rights reserved.
//  连击动画视图

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GiftComboViewState) {
    GiftComboViewStateUnknown = 0,
    GiftComboViewStateIdle,                                      //闲置
    GiftComboViewStateAnimating,                                 //正在执行动画
    GiftComboViewStateWaiting,                                   //等待动画结束
    GiftComboViewStateEnding                                     //结束
};

@class GiftModel;
@interface GiftComboView : UIView

@property (nonatomic, assign) GiftComboViewState state;          //状态

@property (nonatomic, strong) GiftModel *giftModel;              //礼物模型

@property (nonatomic, assign) NSInteger cacheNum;                   //缓存数量(用来检查是否连续送)

@property (nonatomic, copy) void(^animationFinishedCompletion)(GiftComboView *comboView);                                                     //动画完成回调

/** 加载xib*/
+ (GiftComboView *)loadGiftComboView;

/** 添加缓存*/
- (void)addOnceAnimationToCache;

@end
