//
//  GiftContainerView.h
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GiftModel;
@interface GiftContainerView : UIView

/** 添加礼物*/
- (void)addGift:(GiftModel *)giftModel;

@end
