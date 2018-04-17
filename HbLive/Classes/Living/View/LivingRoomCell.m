//
//  LivingRoomCell.m
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "LivingRoomCell.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import <SDWebImage/SDWebImageDownloader.h>
#import "LivingRoomBottomView.h"
#import "LivingRoomTopView.h"
#import "GiftContainerView.h"
#import "DMHeartFlyView.h"
#import "CreatorItem.h"
#import "GiftView.h"
#import "GiftModel.h"
#import "UserHelper.h"

@interface LivingRoomCell()
{
    NSString *_flv;
}

/** 直播开始前的占位图片*/
@property(nonatomic, weak) UIImageView *placeHolderView;

/** 顶部view*/
@property (nonatomic, weak) LivingRoomTopView *topView;
/** 底部view*/
@property(nonatomic, weak) LivingRoomBottomView *bottomView;

//@property (nonatomic, weak) DMHeartFlyView *heartView;


/** 直播播放器*/
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;
/** 播放器属性*/
@property (nonatomic, strong) IJKFFOptions *options;

/** 粒子动画*/
@property(nonatomic, weak) CAEmitterLayer *emitterLayer;

@property (nonatomic, strong) HbSessionManager *sessionManager;
/** 礼物*/
@property (nonatomic, weak) GiftView *giftView;
@property (nonatomic, strong) NSMutableArray *giftData;
@property (nonatomic, weak) GiftContainerView *containerView;

@end


@implementation LivingRoomCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

#pragma mark - lazy

- (HbSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[HbSessionManager alloc] init];
    }
    return _sessionManager;
}


- (IJKFFOptions *)options {
    if (!_options) {
        IJKFFOptions *options = [IJKFFOptions optionsByDefault];
        [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
        // 帧速率(fps) 非标准桢率会导致音画不同步，所以只能设定为15或者29.97
        [options setPlayerOptionIntValue:29.97 forKey:@"r"];
        // 置音量大小，256为标准  要设置成两倍音量时则输入512，依此类推
        [options setPlayerOptionIntValue:256 forKey:@"vol"];
        _options = options;
    }
    return _options;
}



- (IJKFFMoviePlayerController *)moviePlayer {
    
    if (!_moviePlayer) {
        IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:_flv withOptions:self.options];
        // 填充fill
        moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
        // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
        moviePlayer.shouldAutoplay = NO;
        // 默认不显示
        moviePlayer.shouldShowHudView = NO;
        [moviePlayer prepareToPlay];
        
        _moviePlayer = moviePlayer;
    }
    return _moviePlayer;
}

- (CAEmitterLayer *)emitterLayer {
    if (!_emitterLayer) {
        CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
        //发射器在xy平面的中心位置
        emitterLayer.emitterPosition = CGPointMake(self.moviePlayer.view.tjp_width - 50, self.moviePlayer.view.tjp_height - 50);
        //发射器尺寸
        emitterLayer.emitterSize = CGSizeMake(20, 20);
        //渲染模式
        emitterLayer.renderMode = kCAEmitterLayerUnordered;
        
        NSMutableArray <CAEmitterCell *>*emitterCellArr = [NSMutableArray array];
        //创建粒子
        for (int i = 0; i < 10; i++) {
            //发射单元
            CAEmitterCell *cell = [CAEmitterCell emitterCell];
            //粒子速率 默认1/s
            cell.birthRate = 1;
            //粒子存活时间
            cell.lifetime = arc4random_uniform(4) + 1;
            //粒子生存时间容差
            cell.lifetimeRange = 1.5;
            //粒子显示内容
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30", i]];
            cell.contents = (__bridge id _Nullable)(([image CGImage]));
            //粒子运动速度
            cell.velocity = arc4random_uniform(100) + 100;
            //粒子运动速度容差
            cell.velocityRange = 80;
            //粒子在xy平面的发射角度
            cell.emissionLongitude = M_PI + M_PI_2;
            //发射角度容差
            cell.emissionRange = M_PI_2 / 6;
            //缩放比例
            cell.scale = 0.3;
            [emitterCellArr addObject:cell];
        }
        
        emitterLayer.emitterCells = emitterCellArr;
        [self.moviePlayer.view.layer addSublayer:emitterLayer];
        _emitterLayer = emitterLayer;
    }
    return _emitterLayer;
}


- (UIImageView *)placeHolderView {
    if (!_placeHolderView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        _placeHolderView = imageView;
    }
    return _placeHolderView;
}

- (LivingRoomBottomView *)bottomView {
    if (!_bottomView) {
        LivingRoomBottomView *bottomView = [LivingRoomBottomView bottomView];
        bottomView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:bottomView];
        _bottomView = bottomView;
    }
    return _bottomView;
    
}

- (LivingRoomTopView *)topView {
    if (!_topView) {
        LivingRoomTopView *topView = [[LivingRoomTopView alloc] initWithFrame:CGRectZero];
        topView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:topView];
        _topView = topView;
    }
    return _topView;
}

- (GiftView *)giftView {
    if (!_giftView) {
        GiftView *giftView = [GiftView giftViewWithFrame:[UIScreen mainScreen].bounds];
        [self.contentView addSubview:giftView];
        _giftView = giftView;
        WS(weakSelf)
        _giftView.sendGiftBlock = ^(NSString *username, NSString *giftName, NSString *giftIcon) {
            GiftModel *model = [[GiftModel alloc] initWithSenderName:username senderIcon:[UserHelper userHeadImage] giftIcon:giftIcon giftName:giftName];
            [weakSelf.containerView addGift:model];
        };
    }
    return _giftView;
}


- (NSMutableArray *)giftData {
    if (!_giftData) {
        _giftData = [NSMutableArray array];
    }
    return _giftData;
}

- (GiftContainerView *)containerView {
    if (!_containerView) {
        GiftContainerView *containerView = [[GiftContainerView alloc] initWithFrame:CGRectMake(0, 120, 250, 200)];
        //        containerView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:containerView];
        _containerView = containerView;
    }
    return _containerView;
}



#pragma mark - setter
- (void)setLiveItem:(HotLiveItem *)liveItem
{
    _liveItem = liveItem;
    self.topView.liveItem = liveItem;
    [self loadDataWithLivingRoomSource];
    
    NSURL *imageUrl;
    if ([liveItem.creator.portrait hasPrefix:@"http://"]) {
        imageUrl = [NSURL URLWithString:liveItem.creator.portrait];
    }else {
        imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",liveItem.creator.portrait]];
    }
    //play
    [self playWithFLV:liveItem.stream_addr placeHolderUrl:imageUrl];
    
}


- (void)loadDataWithLivingRoomSource {
    WS(weakSelf)
    //top user
    [[RequestDataTool shareInstance] getLivingRoomTopUserModelsWithLiveID:_liveItem.ID result:^(NSMutableArray<LiveRoomTopUserItem *> *topUserModels) {
        weakSelf.topView.topUsers = topUserModels;
    }];
    
    //gift
    [[RequestDataTool shareInstance] getLivingRoomGiftModels:^(NSMutableArray *giftModels) {
        weakSelf.giftData = giftModels;
    }];
}




#pragma mark - method
- (void)playWithFLV:(NSString *)flv placeHolderUrl:(NSURL *)placeHolderUrl {
    
    _flv = flv;
    if (_moviePlayer) {
        if (_moviePlayer) {
            [self.contentView insertSubview:self.placeHolderView aboveSubview:_moviePlayer.view];
        }
        [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
        [self removeMovieNotificationObservers];
    }
    
    //如果有粒子动画,先移除
    [self removeEmitter];
    WS(weakSelf)
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:placeHolderUrl options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.placeHolderView setImageToBlur:image completionBlock:nil];
        });
    }];
    
    [self.contentView insertSubview:self.moviePlayer.view atIndex:0];
    
    
    //添加监听
    [self addObserveForMoviePlayer];
    
    //创建顶部视图
    self.topView.backgroundColor = [UIColor clearColor];
    
    //创建底部视图
    [self setupBottomView];
    //礼物视图
    [self containerView];
    
}



- (void)setupBottomView {
    WS(weakSelf)
    [self.bottomView setButtonClickedBlock:^(LivingRoomBottomViewButtonClickType clickType, UIButton *button) {
        switch (clickType) {
            case LivingRoomBottomViewButtonClickTypeChat:
            {
                TJPLog(@"chat");
            }
                break;
            case LivingRoomBottomViewButtonClickTypeMessage:
            {
                TJPLog(@"Message");
                
            }
                break;
            case LivingRoomBottomViewButtonClickTypeGift:
            {
                TJPLog(@"gift");
                [weakSelf giftView];
                weakSelf.giftView.giftData = weakSelf.giftData;;
                [weakSelf.giftView actionSheetViewShow];
            }
                break;
            case LivingRoomBottomViewButtonClickTypeShare:
            {
                TJPLog(@"share");
                [weakSelf removeEmitter];
                //点击出心
                [weakSelf beginAnimation:button];
            }
                break;
            case LivingRoomBottomViewButtonClickTypeBack:
            {
                TJPLog(@"back");
                [weakSelf playStop];
                
            }
                break;
                
            default:
                break;
        }
    }];
    
}

/** 移除粒子动画*/
- (void)removeEmitter {
    if (_emitterLayer) {
        [_emitterLayer removeFromSuperlayer];
        _emitterLayer = nil;
    }
}

/** 按钮的动画*/
- (void)beginAnimation:(UIButton *)button {
    CGFloat _heartSize = 36;
    DMHeartFlyView *heart = [[DMHeartFlyView alloc] initWithFrame:CGRectMake(button.frame.origin.x, kScreenHeight - self.bottomView.tjp_height, _heartSize, _heartSize)];
    [self.contentView addSubview:heart];
    [heart animateInView:self.contentView];
    
    
    CAKeyframeAnimation *btnAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    btnAnimation.values = @[@(1.0),@(0.7),@(0.5),@(0.3),@(0.5),@(0.7),@(1.0), @(1.2), @(1.4), @(1.2), @(1.0)];
    btnAnimation.keyTimes = @[@(0.0),@(0.1),@(0.2),@(0.3),@(0.4),@(0.5),@(0.6),@(0.7),@(0.8),@(0.9),@(1.0)];
    btnAnimation.calculationMode = kCAAnimationLinear;
    btnAnimation.duration = 0.3;
    [button.layer addAnimation:btnAnimation forKey:nil];
    
}




//返回,停播
- (void)playStop
{
    // 停播
    if (_moviePlayer) {
        [self.moviePlayer shutdown];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    //移除粒子动画
    if (_emitterLayer) {
        [_emitterLayer removeFromSuperlayer];
        _emitterLayer = nil;
    }
    
    [self.parentVc.navigationController popViewControllerAnimated:YES];
}




#pragma mark - layoutSubviews
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.moviePlayer.view.frame = self.contentView.bounds;
    self.placeHolderView.frame = self.contentView.bounds;
    self.topView.frame = CGRectMake(0, kStatusBarHeight, kScreenWidth, 80);
    self.bottomView.frame = CGRectMake(0, kScreenHeight - 54, kScreenWidth, 44);
    
}



#pragma mark - Notification
- (void)addObserveForMoviePlayer {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_moviePlayer];
    
}


//notification method emplemtation
- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _moviePlayer.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) { //shouldAutoplay 为yes 在这种状态下会自动开始播放
        if (!self.moviePlayer.isPlaying) {
            [self.moviePlayer play];
            //粒子动画开始
            [self.emitterLayer setHidden:NO];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_placeHolderView) {
                    [_placeHolderView removeFromSuperview];
                    _placeHolderView = nil;
                }
            });
        }
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) { //如果正在播放,会在此状态下暂停
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackFinish:(NSNotification*)notification { //播放结束时,或者是用户退出时会触发
    
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {//播放状态改变时,会触发
    
    switch (_moviePlayer.playbackState) {
            
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_moviePlayer.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_moviePlayer.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_moviePlayer.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_moviePlayer.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward: {
            
        }
            break;
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_moviePlayer.playbackState);
            break;
        }
            
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_moviePlayer.playbackState);
            break;
        }
    }
}



#pragma mark - 释放相关
- (void)removeMovieNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_moviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_moviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_moviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_moviePlayer];
    
}

- (void)dealloc {
    TJPLog(@"dealloc方法被调用");
    [self removeMovieNotificationObservers];
    
}

@end
