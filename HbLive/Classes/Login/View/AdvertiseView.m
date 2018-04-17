//
//  TJPAdvertiseView.m
//  TJPYingKe
//
//  Created by Walkman on 2017/3/20.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "AdvertiseView.h"
#import "CacheHelper.h"
#import <SDWebImage/SDWebImageManager.h>

static NSInteger adShowTime = 3;
static CFTimeInterval const duration = 0.25f;

@interface AdvertiseView ()

@property (nonatomic, weak) UIImageView *adImageView; //广告图片
@property (nonatomic, weak) UIButton *showTimeBtn;
@property (nonatomic, weak) NSTimer *timer;



@end

@implementation AdvertiseView
#pragma mark - lazy
- (UIImageView *)adImageView {
    if (!_adImageView) {
        UIImageView *adImageView = [[UIImageView alloc] init];
        adImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adImageTap)];
        [adImageView addGestureRecognizer:tap];
        [self addSubview:adImageView];
        _adImageView = adImageView;
    }
    return _adImageView;
}

- (UIButton *)showTimeBtn {
    if (!_showTimeBtn) {
        UIButton *showTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [showTimeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [showTimeBtn setBackgroundColor:TJPColorA(0, 0, 0, 0.8)];
        showTimeBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        showTimeBtn.layer.cornerRadius = 3;
        showTimeBtn.layer.masksToBounds = YES;
        [showTimeBtn addTarget:self action:@selector(goHomePage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:showTimeBtn];
        _showTimeBtn = showTimeBtn;
        
    }
    return _showTimeBtn;
}


- (NSTimer *)timer {
    if (!_timer) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerGo) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _timer = timer;
    }
    return _timer;
}



#pragma mark - instancetype
+ (instancetype)AdvertiseViewWithType:(AdvertiseViewType)type {
    AdvertiseView *advertiseView = [[AdvertiseView alloc] initWithType:type];
    
    return advertiseView;
}


- (instancetype)initWithType:(AdvertiseViewType)type {
    if (self = [super init]) {
        if (type == AdvertiseViewTypeFullScreen) {
            self.adImageView.frame = [UIScreen mainScreen].bounds;
        }else if (type == AdvertiseViewTypeLogo) {
            self.adImageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kScreenWidth / 3);
        }else {
            self.adImageView.frame = [UIScreen mainScreen].bounds;
        }
        [self initialization];
    }
    return self;
}


- (void)initialization {
    self.frame = [UIScreen mainScreen].bounds;
    UIImage *launchImage = [UIImage imageNamed:[self getLaunchImage]];
    self.backgroundColor = [UIColor colorWithPatternImage:launchImage];
    //timer
    [self timer];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_showTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.top.offset(30);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
}


#pragma mark - setter&getter
- (void)setLocalImageName:(NSString *)localImageName {
    _localImageName = localImageName;
}


#pragma mark - Method implementation
- (void)adImageTap {
    if (self.clickBlock) {
        self.clickBlock([CacheHelper getAdvertiseLink]);
    }
}

- (void)goHomePage {
    [self advertiseViewHidden];
}


/** 展示广告*/
- (void)advertiseShow {
    //1.判断缓存中是否有图片
    UIImage *lastCacheImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:[CacheHelper getAdvertiseImage]];
    if (!lastCacheImage) {
        //2.判断是否有本地图片
        if (!_localImageName.length) { //没有本地图片
            //3.下载图片
            [self downloadAdvertise];
            //4.移除此视图
            self.hidden = YES;
            [self remove];
        }else {
            _adImageView.image = [UIImage imageNamed:_localImageName];
            [self downloadAdvertise];
        }
    }else {
        _adImageView.image = lastCacheImage;
    }
}

//下载广告
- (void)downloadAdvertise {
    [[RequestDataTool shareInstance] getAdvertiseModel:^(AdvertiseModel *model) {
        NSURL *imageUrl = [NSURL URLWithString:model.image];
        if (![model.image hasPrefix:@"http://"]) {
            imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCommonServiceAPI, model.image]];
        }
//        //通过sd下载
//        [[SDWebImageManager sharedManager] downloadImageWithURL:imageUrl
//                                                        options:SDWebImageAvoidAutoSetImage
//                                                       progress:nil
//                                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                                                          [CacheHelper setAdvertiseImage:model.image];
//                                                          [CacheHelper setAdvertiseLink:model.link];
//                                                          TJPLog(@"广告图片下载成功");
//                                                      }];
        
    }];
}


//定时器方法
- (void)timerGo {
    if (adShowTime == 0) {
        //销毁定时器
        [_timer invalidate];
        _timer = nil;
        //隐藏视图
        [self timeBtnHidden];
        [self advertiseViewHidden];
    }else {
        [self.showTimeBtn setTitle:[NSString stringWithFormat:@"跳过%@", @(adShowTime--)] forState:UIControlStateNormal];
    }
}

//按钮隐藏
- (void)timeBtnHidden {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = duration;
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    [_showTimeBtn.layer addAnimation:opacityAnimation forKey:@"timeBtnHidden"];
}


//隐藏广告视图
- (void)advertiseViewHidden {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
        _adImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [self remove];
    }];
}
//移除
- (void)remove {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}
/** 清除广告图片缓存*/
- (void)cleanAdvertiseImageCache {
//    [[SDImageCache sharedImageCache] removeImageForKey:[CacheHelper getAdvertiseImage]];
//    [CacheHelper removeAdvertiseAllData];
}



//获取启动图片
- (NSString *)getLaunchImage {
    NSString *launchImageName = nil;
    NSString *orentationStr = @"Portrait";
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSArray <NSDictionary *>*launchImages = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dic in launchImages) {
        CGSize imageSize = CGSizeFromString(dic[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [orentationStr isEqualToString:dic[@"UILaunchImageOrientation"]]) {
            launchImageName = dic[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}


#pragma mark - dealloc 
- (void)dealloc {
    TJPLogFunc
}



@end
