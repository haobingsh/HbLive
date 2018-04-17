//
//  CountLabel.h
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountLabel : UILabel

/** 开始动画*/
- (void)startAnimation:(void(^)())complection;


@end
