//
//  HbNavigationController.h
//  HbLive
//
//  Created by 郝兵 on 2018/4/16.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HbNavigationController : UINavigationController

/**
 全屏返回手势
 
 @param isForBidden 是否禁止
 */
- (void)setupBackPanGestureIsForbiddden:(BOOL)isForBidden;

@end
