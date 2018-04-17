//
//  UIViewController+Loading.m
//  NeiHan
//
//  Created by Charles on 16/5/15.
//  Copyright © 2016年 Com.Charles. All rights reserved.
//

#import "UIViewController+Loading.h"
#import <objc/message.h>

const static char loadingViewKey;

@interface UIViewControllerLodingView : UIView
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;
@end

@implementation UIViewControllerLodingView

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13.f];
        label.textColor = [UIColor colorWithRed:0.32f green:0.36f blue:0.40f alpha:1.f];
        label.text = @"正在加载...";
        [self addSubview:label];
        _label = label;
    }
    return _label;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}

- (void)startAnimating {
    [self.indicatorView startAnimating];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = CGRectMake(self.tjp_width/ 2.0 - 30, self.tjp_height / 2.0 - 40, 80, 40);
    self.indicatorView.frame = CGRectMake(self.tjp_width / 2.0 - 70, self.label.tjp_y, 40, 40);
}

@end

@implementation UIViewController (Loading)

- (void)showLoadingView {
    [self showLoadingViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
}

- (UIView *)loadingView {
    return objc_getAssociatedObject(self, &loadingViewKey);
}

- (void)setLoadingView:(UIView *)loadingView {
    objc_setAssociatedObject(self, &loadingViewKey, loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showLoadingViewWithFrame:(CGRect)frame {
    if (!self.loadingView) {
        UIViewControllerLodingView *loadingView = [[UIViewControllerLodingView alloc]
                                                init];
        self.loadingView = loadingView;
//        loadingView.backgroundColor = [UIColor redColor];
        loadingView.frame = frame;
        [self.view addSubview:self.loadingView];
        loadingView.center = self.view.center;
        loadingView.tjp_centerY = self.view.tjp_centerY - 50;
        [loadingView startAnimating];
    }
}

- (void)hideLoadingView {
    if (self.loadingView) {
        [self.loadingView removeFromSuperview];
    }
}
@end
