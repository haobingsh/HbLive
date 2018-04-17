//
//  TJPWebProgressLayer.h
//  FengYou
//
//  Created by Walkman on 2017/2/23.
//  Copyright © 2017年 AaronTang. All rights reserved.
//  WebView进度条

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface WebProgressLayer : CAShapeLayer

/** 进度条颜色*/
@property (nonatomic, strong) UIColor *progressColor;



/** 进度开始加载  WKWebView使用*/
- (void)startLoadWithProgress:(CGFloat)progress;
/** 结束加载     WKWebView使用*/
- (void)finishedLoadWhenProgressEnd;



/** 开始加载     UIWebVIew使用*/
- (void)startLoad;

/** 结束加载     UIWebVIew使用*/
- (void)finishedLoad;

- (void)closeTimer;

@end
