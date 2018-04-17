//
//  TJPWebProgressLayer.m
//  FengYou
//
//  Created by Walkman on 2017/2/23.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "WebProgressLayer.h"
#import "NSTimer+Addition.h"

static NSTimeInterval const kFastTimeInterval = 0.003;

@interface WebProgressLayer ()

@property (nonatomic, weak) NSTimer *timer;


@end

@implementation WebProgressLayer
{
    CAShapeLayer *_layer;
    CGFloat _plusWidth;
}

#pragma mark - lazy
- (NSTimer *)timer {
    if (!_timer) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:kFastTimeInterval target:self selector:@selector(pathChanged:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
        _timer = timer;
    }
    return _timer;
}

#pragma mark - method
- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}



//初始化
- (void)initialize {
    
    self.lineWidth = 2;
    self.strokeColor = [UIColor redColor].CGColor;
    self.strokeEnd = 0;
    self.path = [self getBezierPath];
    _plusWidth = 0.01;
    //timer
    [self timer];
}


#pragma mark - WKWebView使用
//进度开始加载
- (void)startLoadWithProgress:(CGFloat)progress {
    self.strokeEnd += progress;
}

//结束加载
- (void)finishedLoadWhenProgressEnd {
    [self removeLayer];
}


#pragma mark - UIWebView使用
//开始加载
- (void)startLoad {
    [_timer resumeWithTimeInterval:kFastTimeInterval];
}

//结束加载
- (void)finishedLoad {
    [self closeTimer];
    [self removeLayer];
}

//关闭定时器
- (void)closeTimer {
    [_timer invalidate];
    _timer = nil;
}


#pragma privite
- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    if ([self.progressColor isKindOfClass:[UIColor class]]) {
        self.strokeColor = progressColor.CGColor;
    }
}
- (void)pathChanged:(NSTimer *)timer {
    self.strokeEnd += _plusWidth;
    if (self.strokeEnd > 0.8) {
        _plusWidth = 0.002;
    }
}


- (CGPathRef)getBezierPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 2)];
    [path addLineToPoint:CGPointMake(kScreenWidth, 2)];
    return path.CGPath;
}


- (void)removeLayer {
    self.strokeEnd = 1.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        [self removeFromSuperlayer];
    });
}

- (void)dealloc {
    [self closeTimer];
}



@end

