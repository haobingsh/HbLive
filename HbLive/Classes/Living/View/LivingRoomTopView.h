//
//  LivingRoomTopView.h
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotLiveItem;
@interface LivingRoomTopView : UIView

/** model*/
@property (nonatomic, strong) HotLiveItem *liveItem;
/** 顶部数据*/
@property (nonatomic, strong) NSMutableArray *topUsers;

@property (nonatomic, copy) void(^followBtnClickBlock)(UIButton *button);

@end
