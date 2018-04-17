//
//  LivingRoomCell.h
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotLiveItem.h"
#import "LivingRoomTopView.h"

@interface LivingRoomCell : UICollectionViewCell


/** model*/
@property (nonatomic, strong) HotLiveItem *liveItem;

/** 父控制器*/
@property (nonatomic, weak) UIViewController *parentVc;

@end
