//
//  CountLabel.m
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "CountLabel.h"

@implementation CountLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

//label的描边效果
- (void)drawRect:(CGRect)rect {
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.画出第一层文字
    CGContextSetTextDrawingMode(ctx, kCGTextStroke);
    CGContextSetLineWidth(ctx, 5);
    
    //    设置拐弯平缓
    CGContextSetLineCap(ctx, kCGLineCapRound); //LineCap设置线条
    CGContextSetLineJoin(ctx, kCGLineJoinRound); //LineJoin设置拐角
    self.textColor = kGlobalLightBlueColor;
    [super drawRect:rect];
    
    //2.画出第二层文字
    CGContextSetTextDrawingMode(ctx, kCGTextFill); //设置模式
    CGContextSetLineWidth(ctx, 2.0);
    self.textColor = [UIColor yellowColor];
    
    [super drawRect:rect];
    
}


/** 开始动画*/
- (void)startAnimation:(void(^)())complection {
    //通过核心动画
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations:^{
        //StartTime 开始的时间  relativeDuration经过多久
        //在Keyframe整个动画中 添加一帧一帧的小动画     此处是按比例的 并非实际0.3s
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.3 animations:^{
            //此处放想用的动画
            self.transform = CGAffineTransformMakeScale(3.f, 3.f);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.4 animations:^{
            self.transform = CGAffineTransformMakeScale(0.6f, 0.6f);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.3 animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
    } completion:^(BOOL finished) {
        complection();
    }];
    
    
    
}

@end
