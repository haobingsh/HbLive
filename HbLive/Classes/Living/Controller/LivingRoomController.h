//
//  LivingRoomController.h
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LivingRoomController : UICollectionViewController

/** 直播数据源*/
@property (nonatomic, strong) NSArray *liveDatas;
/** 当前的index*/
@property (nonatomic, assign) NSUInteger currentIndex;

@end
