//
//  HbTabBar.h
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HbTabBar : UITabBar

/** 中间按钮点击回调*/
@property (nonatomic, copy) void(^centerBtnClickBlock)();

@end
