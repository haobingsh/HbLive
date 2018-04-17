//
//  TJPGiftChanneView.m
//  TestAnimation
//
//  Created by Walkman on 2017/3/1.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "GiftComboView.h"
#import "UIView+GiftExtension.h"
#import "CountLabel.h"
#import "GiftModel.h"
#import <SDWebImage/UIImageView+WebCache.h>


//#define kScreenWidth                    [UIScreen mainScreen].bounds.size.width
//#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define kAnimateDuration                0.25


@interface GiftComboView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *senderLabel;
@property (weak, nonatomic) IBOutlet UILabel *giftDescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;
@property (weak, nonatomic) IBOutlet CountLabel *giftCountLabel;


@property (nonatomic, assign) NSInteger currentNum; //用来标记当前礼物数量

@end

@implementation GiftComboView


#pragma mark - 初始化相关
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void) initialize{
    //初始化属性
    self.currentNum = 0;
    self.cacheNum = 0;
    //状态初始为闲置
    self.state = GiftComboViewStateIdle;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bgView.layer.cornerRadius = self.bgView.tjp_height * 0.5;
    self.bgView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = self.iconImageView.tjp_height * 0.5;
    self.iconImageView.layer.borderWidth = 0.5;
    self.iconImageView.layer.borderColor = kGlobalLightBlueColor.CGColor;
    self.iconImageView.layer.masksToBounds = YES;

}


- (void)setGiftModel:(GiftModel *)giftModel {
    _giftModel = giftModel;
    //判断模型是否为空
    if (giftModel == nil) {
        return;
    }
    //给属性赋值
    self.iconImageView.image = [UIImage imageNamed:giftModel.senderIcon];
    self.senderLabel.text = giftModel.senderName;
    self.giftDescLabel.text = [NSString stringWithFormat:@"送出礼物【%@】", giftModel.giftName];
    [self.giftImageView sd_setImageWithURL:[NSURL URLWithString:giftModel.giftIcon]];
    
    //执行栈道动画
    [self performShowAnimation];
}

/** 栈道动画*/
- (void)performShowAnimation {
    //状态变为开始动画
    self.state = GiftComboViewStateAnimating;
    //执行栈道动画
    [UIView animateWithDuration:kAnimateDuration animations:^{
        self.tjp_x = 0;
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        //显示出label
        self.giftCountLabel.alpha = 1.0;
        //执行label的弹动动画
        [self performGiftCountLabelAnimation];
    }];
}

/** label的弹动动画*/
- (void)performGiftCountLabelAnimation {
    _currentNum += 1;
    //改变label显示的内容
    self.giftCountLabel.text = [NSString stringWithFormat:@" x %zi ", _currentNum];
    //执行动画
    [self.giftCountLabel startAnimation:^{
        //动画完成  判断是否有缓存
        if (_cacheNum > 0) {
            _cacheNum -= 1;
            [self performGiftCountLabelAnimation]; //通过递归清除缓存
        }else {
            //等待3秒钟执行结束动画
            [self performSelector:@selector(perFormDismissAnimationi) withObject:nil afterDelay:3.0];
            //状态变为等待结束
            self.state = GiftComboViewStateWaiting;
        }
    }];
}

/** 结束动画*/
- (void)perFormDismissAnimationi {
    //状态变为结束
    self.state = GiftComboViewStateEnding;
    [UIView animateWithDuration:kAnimateDuration animations:^{
        self.tjp_x = kScreenWidth;
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        //重置&销毁
        self.currentNum = 0;
        self.giftCountLabel.alpha = 0.0;
        self.tjp_x = -kScreenWidth;
        self.giftModel = nil;
        //状态变为闲置
        self.state = GiftComboViewStateIdle;
        //通知容器视图 已完成动画
        self.animationFinishedCompletion(self);
    }];
    
}



#pragma mark - 外部要用到的接口
+ (GiftComboView *)loadGiftComboView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}


- (void)addOnceAnimationToCache {
    if (self.state == GiftComboViewStateAnimating) { //正在执行动画的时候 缓存++
        _cacheNum += 1;
    }else if (self.state == GiftComboViewStateWaiting) { //正在等待结束
        //取消之前3秒后要结束的方法 并执行label动画
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performGiftCountLabelAnimation];
    }else if (self.state == GiftComboViewStateIdle) { //闲置
//        [self performShowAnimation];
    }else {
        NSLog(@"%ld", (long)self.state);
    }
    
}



@end
